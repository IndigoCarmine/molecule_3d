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

class Sphere3D extends Group3D {
  Sphere3D(this.radius, this.position, {this.color})
      : super(_getFigures(radius, position, color: color));

  //for testing
  double radius;
  vm64.Vector3 position;
  Color? color;
}

List<Model3D> _getFigures(double radius, vm64.Vector3 position,
    {Color? color}) {
  //make sphere vertex
  final sphere = SphereGenerator();
  final mesh = sphere.createSphere(radius, latSegments: 5, lonSegments: 6);
  final vertex = mesh.getViewForAttrib('POSITION')! as Vector3List;
  final index = mesh.indices!;
  final vertices = <vm.Vector3>[];

  for (var i = 0; i < vertex.length; i++) {
    vm.Vector3 v = vm.Vector3.zero();
    vertex.load(i, v);
    vertices.add(v);
  }
  //transform vertex
  List<Model3D> triangles = [];
  for (var i = 0; i < index.length; i += 3) {
    final triangle = vm64.Triangle.points(
      vertices[index[i]].toVM64() + position,
      vertices[index[i + 1]].toVM64() + position,
      vertices[index[i + 2]].toVM64() + position,
    );
    triangles.add(Face3D(triangle, color: color));
  }
  return triangles;
}
