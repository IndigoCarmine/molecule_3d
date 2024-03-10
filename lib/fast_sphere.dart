import 'dart:ffi';
import 'dart:typed_data';

import 'package:ditredi/ditredi.dart';
import 'dart:ui';
import 'package:vector_math/vector_math.dart' as vm;
import 'package:vector_math/vector_math_64.dart' as vm64;
import "package:vector_math/vector_math_geometry.dart";
import 'package:vector_math/vector_math_lists.dart';

extension VME on vm.Vector3 {
  vm64.Vector3 toVM64() {
    return vm64.Vector3(x, y, z);
  }
}

class FastSphere3D extends Model3D<FastSphere3D> with FastSpherePainter {
  FastSphere3D(this.radius, this.position, this.color) {
    final sphere = SphereGenerator();
    final mesh = sphere.createSphere(radius, latSegments: 5, lonSegments: 5);
    sphereVertices = (mesh.getViewForAttrib('POSITION')! as Vector3List);
    indices = mesh.indices!;
  }

  final Color? color;
  final vm64.Vector3 position;
  final double radius;
  late Vector3List sphereVertices;
  late Uint16List indices;

  @override
  FastSphere3D clone() {
    return FastSphere3D(radius, position, color);
  }

  @override
  vm64.Aabb3 getBounds() {
    return vm64.Aabb3.fromSphere(vm64.Sphere.centerRadius(position, radius));
  }

  @override
  List<Line3D> toLines() {
    List<Line3D> lines = [];
    for (var i = 0; i < sphereVertices.length / 2; i += 2) {
      lines.add(Line3D(
        sphereVertices[i].toVM64() + position,
        sphereVertices[i + 1].toVM64() + position,
      ));
    }
    return lines.toSet().toList();
  }

  @override
  List<Point3D> toPoints() {
    List<Point3D> points = [];
    for (var i = 0; i < sphereVertices.length / 3; i++) {
      points.add(Point3D(sphereVertices[i].toVM64() + position, color: color));
    }
    return points.toSet().toList();
  }

  @override
  int verticesCount() {
    return indices.length;
  }
}

mixin FastSpherePainter implements Model3DPainter<FastSphere3D> {
  @override
  void paint(
      DiTreDiConfig config,
      DiTreDiController controller,
      PaintViewPort viewPort,
      FastSphere3D model,
      vm64.Matrix4 matrix,
      int vertexIndex,
      Float32List zIndices,
      Int32List colors,
      Float32List vertices) {
    Vector3List v = model.sphereVertices;
    var pos = model.position.clone();
    matrix.perspectiveTransform(pos);
    zIndices[vertexIndex ~/ 3] = pos.z;

    Vector2List vertex = Vector2List(v.length);
    // print(model.position);
    var vec = vm64.Vector3.zero();
    for (var i = 0; i < v.length; i++) {
      vec.setValues(v[i].x + model.position.x, v[i].y + model.position.y,
          v[i].z + model.position.z);
      matrix.perspectiveTransform(vec);
      vertex.setValues(i, vec.x, vec.y);
    }

    for (var i = 0; i < model.verticesCount(); i++) {
      vertices[vertexIndex * 2 + i * 2] = vertex[model.indices[i]].x;
      vertices[vertexIndex * 2 + i * 2 + 1] = vertex[model.indices[i]].y;
      // print("vertexIndex:${vertices[vertexIndex + i * 2]}");
    }

    // print("vertexIndex:${v.length}");
    // print(vertices.length);
    colors.fillRange(vertexIndex, vertexIndex + model.verticesCount(),
        model.color?.value ?? 0);
  }
}
