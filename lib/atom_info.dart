import 'package:flutter/painting.dart';

class AtomInfo {
  final Color color;
  final double radius; // in angstroms

  const AtomInfo(this.color, this.radius);
}

const atoms = <String, AtomInfo>{
  'H': AtomInfo(Color.fromARGB(255, 255, 255, 255), 0.25),
  'He': AtomInfo(Color.fromARGB(255, 217, 255, 255), 0.31),
  'Li': AtomInfo(Color.fromARGB(255, 204, 128, 255), 1.45),
  'Be': AtomInfo(Color.fromARGB(255, 194, 255, 0), 1.05),
  'B': AtomInfo(Color.fromARGB(255, 255, 181, 181), 0.85),
  'C': AtomInfo(Color.fromARGB(255, 144, 144, 144), 0.70),
  'N': AtomInfo(Color.fromARGB(255, 48, 80, 248), 0.65),
  'O': AtomInfo(Color.fromARGB(255, 255, 13, 13), 0.60),
  'F': AtomInfo(Color.fromARGB(255, 144, 224, 80), 0.50),
  'Ne': AtomInfo(Color.fromARGB(255, 179, 227, 245), 0.38),
  'Na': AtomInfo(Color.fromARGB(255, 171, 92, 242), 1.80),
  'Mg': AtomInfo(Color.fromARGB(255, 138, 255, 0), 1.50),
  'Al': AtomInfo(Color.fromARGB(255, 191, 166, 166), 1.25),
  'Si': AtomInfo(Color.fromARGB(255, 240, 200, 160), 1.10),
  'P': AtomInfo(Color.fromARGB(255, 255, 128, 0), 1.00),
  'S': AtomInfo(Color.fromARGB(255, 255, 255, 48), 1.00),
  'Cl': AtomInfo(Color.fromARGB(255, 31, 240, 31), 1.00),
  'Ar': AtomInfo(Color.fromARGB(255, 128, 209, 227), 1.00),
  'K': AtomInfo(Color.fromARGB(255, 143, 64, 212), 2.20),
  'Ca': AtomInfo(Color.fromARGB(255, 61, 255, 0), 1.80),
  'Sc': AtomInfo(Color.fromARGB(255, 230, 230, 230), 1.60),
  'Ti': AtomInfo(Color.fromARGB(255, 191, 194, 199), 1.40),
  'V': AtomInfo(Color.fromARGB(255, 166, 166, 171), 1.35),
  'Cr': AtomInfo(Color.fromARGB(255, 138, 153, 199), 1.40),
  'Mn': AtomInfo(Color.fromARGB(255, 156, 122, 199), 1.40),
  'Fe': AtomInfo(Color.fromARGB(255, 224, 102, 51), 1.40),
  'Co': AtomInfo(Color.fromARGB(255, 240, 144, 160), 1.35),
  'Ni': AtomInfo(Color.fromARGB(255, 80, 208, 80), 1.35),
  'Cu': AtomInfo(Color.fromARGB(255, 200, 128, 51), 1.35),
  'Zn': AtomInfo(Color.fromARGB(255, 125, 128, 176), 1.35),
  'Ga': AtomInfo(Color.fromARGB(255, 194, 143, 143), 1.30),
  'Ge': AtomInfo(Color.fromARGB(255, 102, 143, 143), 1.25),
  'As': AtomInfo(Color.fromARGB(255, 189, 128, 227), 1.15),
  'Se': AtomInfo(Color.fromARGB(255, 255, 161, 0), 1.15),
  'Br': AtomInfo(Color.fromARGB(255, 166, 41, 41), 1.15),
  'Kr': AtomInfo(Color.fromARGB(255, 92, 184, 209), 1.15),
};
