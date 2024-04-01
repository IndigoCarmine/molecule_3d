import 'dart:math';
import 'package:flutter/material.dart';
import 'package:molecule_3d/atom_info.dart';
import 'package:vector_math/vector_math_64.dart' show Aabb3, Matrix4, Vector3;

class MolecularViewerController extends ChangeNotifier {
  double rotationX;
  double rotationY;
  double rotationZ;
  Vector3 position;
  double zoom;

  MolecularViewerController(
      {this.rotationX = 0,
      this.rotationY = 0,
      this.rotationZ = 0,
      this.zoom = 1.0})
      : position = Vector3(0, 0, 0);

  void update({
    double? rotationX,
    double? rotationY,
    double? rotationZ,
    double? zoom,
    Vector3? position,
    Vector3? viewDirection,
  }) {
    this.rotationX = rotationX ?? this.rotationX;
    this.rotationY = rotationY ?? this.rotationY;
    this.rotationZ = rotationZ ?? this.rotationZ;
    this.zoom = zoom ?? this.zoom;
    this.position = position ?? this.position;
    notifyListeners();
  }
}

class MolecularViewerDraggable extends StatefulWidget {
  final MolecularViewerController controller;
  final Widget child;

  /// A widget that allows the user to rotate and zoom a molecular structure.
  /// The child widget is the [MolecularViewer] widget.
  const MolecularViewerDraggable(
      {super.key, required this.controller, required this.child});

  @override
  State<MolecularViewerDraggable> createState() =>
      _MolecularViewerDraggableState();
}

class _MolecularViewerDraggableState extends State<MolecularViewerDraggable> {
  var _lastX = 0.0;
  var _lastY = 0.0;
  var _rotationX = 0.0;
  var _rotationY = 0.0;
  var _zoom = 1.0;
  final _scale = 0.01;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onScaleStart: (details) {
        _lastX = details.localFocalPoint.dx;
        _lastY = details.localFocalPoint.dy;
        _rotationX = widget.controller.rotationX;
        _rotationY = widget.controller.rotationY;
        _zoom = widget.controller.zoom;
      },
      onScaleUpdate: (details) {
        final dx = details.localFocalPoint.dx - _lastX;
        final dy = details.localFocalPoint.dy - _lastY;
        widget.controller.update(
          rotationX: _rotationX - dy * _scale,
          rotationY: _rotationY - dx * _scale,
          zoom: _zoom * ((details.scale - 1) * _scale * 100 + 1),
        );
      },
      child: widget.child,
    );
  }
}

class MolecularViewer extends StatelessWidget {
  final List<AtomObject> atoms;
  final MolecularViewerController controller;

  /// A widget that displays a molecular structure.
  /// Strutegy: Atoms are drawn as circles with a shader that simulates a sphere.
  MolecularViewer(
      {super.key, required this.atoms, MolecularViewerController? controller})
      : controller = controller ?? MolecularViewerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: CustomPaint(
        painter: MolecularPainter(atoms: atoms, controller: controller),
        size: Size.infinite,
      ),
    );
  }
}

/// Load atoms from xyz file format.
List<AtomObject> loadXyz(String xyz) {
  final atomObjects = <AtomObject>[];
  final lines = xyz.split('\n');
  for (var line in lines) {
    final parts = line.split(RegExp(r'\s+'));
    if (parts.length == 4) {
      final elementName = parts[0];
      final position = Vector3(
        double.parse(parts[1]),
        double.parse(parts[2]),
        double.parse(parts[3]),
      );
      atomObjects.add(AtomObject.fromElementName(elementName, position));
    }
  }
  return atomObjects;
}

class AtomObject {
  final AtomInfo atom;
  final Vector3 position;

  AtomObject({required this.atom, required this.position});

  AtomObject.fromElementName(String elementName, this.position)
      : atom = atoms[elementName] ?? const AtomInfo(Colors.black, 1.0);

  @override
  String toString() {
    return 'AtomObject{atom: $atom, position: $position}';
  }
}

class MolecularPainter extends CustomPainter {
  final List<AtomObject> atoms;
  final MolecularViewerController controller;
  bool _isDirty = true;
  final Aabb3 _bounds = Aabb3();

  MolecularPainter({required this.controller, required this.atoms})
      : super(repaint: controller) {
    controller.addListener(() {
      _isDirty = true;
    });

    for (var atom in atoms) {
      _bounds.hullPoint(atom.position);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (!_isDirty) return;
    _isDirty = false;
    canvas.save();

    canvas.translate(size.width / 2, size.height / 2);

    final dx = _bounds.center.x;
    final dy = _bounds.center.y;
    final dz = _bounds.center.z;
    final scale = controller.zoom * min(size.width / 2, size.height / 2) / 10;

    Matrix4 matrix = Matrix4.identity();
    matrix
      ..translate(controller.position.x, controller.position.x, 0)
      ..translate(-dx * scale, dy * scale, dz * scale)
      ..scale(scale, -scale, -scale)
      ..translate(dx, dy, dz)
      ..rotateX(controller.rotationX)
      ..rotateY(controller.rotationY)
      ..rotateZ(controller.rotationZ)
      ..translate(-dx, -dy, -dz);

    final preparedAtoms = atoms.map((atom) {
      return AtomObject(
          atom: atom.atom,
          position: matrix.perspectiveTransform(atom.position.clone()));
    }).toList()
      ..sort((a, b) => a.position.z.compareTo(b.position.z));

    for (final atom in preparedAtoms) {
      //atom position is inside of canvas
      final isInside = atom.position.x > -size.width / 2 &&
          atom.position.x < size.width / 2 &&
          atom.position.y > -size.height / 2 &&
          atom.position.y < size.height / 2;
      if (!isInside) continue;
      _drawAtom(canvas, scale, atom, matrix);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => _isDirty;

  void _drawAtom(Canvas canvas, double scale, AtomObject atom, Matrix4 matrix) {
    final position = atom.position;
    final center = Offset(position.x, position.y);
    final radius = atom.atom.radius * scale;

    //shere-like shader
    const align = -1.414 / 2;
    final paint = Paint()
      ..shader = RadialGradient(
              colors: [Colors.white, atom.atom.color, Colors.black],
              focal: const Alignment(align, align),
              stops: const [0.1, 0.9, 2],
              radius: 0.5,
              tileMode: TileMode.clamp)
          .createShader(Rect.fromCircle(
        center: Offset(position.x, position.y),
        radius: radius,
      ))
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    // final paint = Paint()
    //   ..color = atom.atom.color
    //   ..strokeWidth = 2
    //   ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, paint);
  }
}
