import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ditredi/ditredi.dart';
import 'package:molecule_3d/fast_sphere.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:ui' as ui;
import 'package:molecule_3d/sphere.dart';

class ChemModelViewer extends StatefulWidget {
  const ChemModelViewer({super.key});

  @override
  State<ChemModelViewer> createState() => _ChemModelViewerState();
}

class _ChemModelViewerState extends State<ChemModelViewer> {
  DiTreDiController controller = DiTreDiController();
  @override
  Widget build(BuildContext context) {
    return DiTreDiDraggable(
        controller: controller,
        child: DiTreDi(figures: [
          Mol(30),
        ], controller: controller));
  }
}

class Mol extends Group3D {
  Mol(int n) : super(generateFSphereList(n));
}

List<Model3D> generateSphereList(int n) {
  List<Sphere3D> spheres = [];
  for (double i = 0; i < n; i++) {
    for (double j = 0; j < n; j++) {
      for (double k = 0; k < n; k++) {
        spheres.add(Sphere3D(0.001, Vector3(i, j, k),
            color: Color.fromARGB(255, 255, 0, 0)));
      }
    }
  }
  return spheres;
}

List<Model3D> generateFSphereList(int n) {
  List<FastSphere3D> spheres = [];
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      for (int k = 0; k < n; k++) {
        spheres.add(FastSphere3D(
            0.5,
            Vector3(i.toDouble(), j.toDouble(), k.toDouble()),
            Color.fromARGB(255, 255, 0, 0)));
      }
    }
  }
  return spheres;
}
