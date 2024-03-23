import 'package:ditredi/ditredi.dart';
import 'package:flutter/painting.dart';
import 'package:molecule_3d/atom_info.dart';
import 'package:molecule_3d/fast_sphere.dart';
import 'package:molecule_3d/sphere.dart';
import 'package:vector_math/vector_math_64.dart';

class Atom extends Sphere3D {
  Atom({required String elementName, required Vector3 position})
      : super((atoms[elementName]?.radius ?? 1) * 1.2, position,
            color: atoms[elementName]?.color ?? const Color(0xff000000));

  Atom.fromRaw(
      {required double radius,
      required Vector3 position,
      required Color? color})
      : super(radius, position, color: color);
  @override
  String toString() {
    return 'Atom{position}';
  }
}

class Molecule extends Group3D {
  Molecule(List<Atom> super.atoms);

  factory Molecule.fromXyz(String xyz) {
    return Molecule(loadXyz(xyz));
  }

  @override
  Molecule clone() {
    return Molecule(super.figures as List<Atom>);
  }

  Molecule moveAndClone(Vector3 position) {
    final newAtoms = <Atom>[];
    for (var atom in super.figures as List<Atom>) {
      newAtoms.add(Atom.fromRaw(
          radius: atom.radius,
          position: atom.position + position,
          color: atom.color));
    }
    return Molecule(newAtoms);
  }
}

List<Atom> loadXyz(String xyz) {
  final atoms = <Atom>[];
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
      atoms.add(Atom(elementName: elementName, position: position));
    }
  }
  return atoms;
}
