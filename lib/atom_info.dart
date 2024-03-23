import 'package:flutter/painting.dart';

class Atom {
  final Color color;
  final double radius; // in angstroms

  const Atom(this.color, this.radius);
}

const atoms = <String, Atom>{
  'H': Atom(Color.fromARGB(255, 255, 255, 255), 0.25),
  'He': Atom(Color.fromARGB(255, 217, 255, 255), 0.31),
  'Li': Atom(Color.fromARGB(255, 204, 128, 255), 1.45),
  'Be': Atom(Color.fromARGB(255, 194, 255, 0), 1.05),
  'B': Atom(Color.fromARGB(255, 255, 181, 181), 0.85),
  'C': Atom(Color.fromARGB(255, 144, 144, 144), 0.70),
  'N': Atom(Color.fromARGB(255, 48, 80, 248), 0.65),
  'O': Atom(Color.fromARGB(255, 255, 13, 13), 0.60),
  'F': Atom(Color.fromARGB(255, 144, 224, 80), 0.50),
  'Ne': Atom(Color.fromARGB(255, 179, 227, 245), 0.38),
  'Na': Atom(Color.fromARGB(255, 171, 92, 242), 1.80),
  'Mg': Atom(Color.fromARGB(255, 138, 255, 0), 1.50),
  'Al': Atom(Color.fromARGB(255, 191, 166, 166), 1.25),
  'Si': Atom(Color.fromARGB(255, 240, 200, 160), 1.10),
  'P': Atom(Color.fromARGB(255, 255, 128, 0), 1.00),
  'S': Atom(Color.fromARGB(255, 255, 255, 48), 1.00),
  'Cl': Atom(Color.fromARGB(255, 31, 240, 31), 1.00),
  'Ar': Atom(Color.fromARGB(255, 128, 209, 227), 1.00),
  'K': Atom(Color.fromARGB(255, 143, 64, 212), 2.20),
  'Ca': Atom(Color.fromARGB(255, 61, 255, 0), 1.80),
  'Sc': Atom(Color.fromARGB(255, 230, 230, 230), 1.60),
  'Ti': Atom(Color.fromARGB(255, 191, 194, 199), 1.40),
  'V': Atom(Color.fromARGB(255, 166, 166, 171), 1.35),
  'Cr': Atom(Color.fromARGB(255, 138, 153, 199), 1.40),
  'Mn': Atom(Color.fromARGB(255, 156, 122, 199), 1.40),
  'Fe': Atom(Color.fromARGB(255, 224, 102, 51), 1.40),
  'Co': Atom(Color.fromARGB(255, 240, 144, 160), 1.35),
  'Ni': Atom(Color.fromARGB(255, 80, 208, 80), 1.35),
  'Cu': Atom(Color.fromARGB(255, 200, 128, 51), 1.35),
  'Zn': Atom(Color.fromARGB(255, 125, 128, 176), 1.35),
  'Ga': Atom(Color.fromARGB(255, 194, 143, 143), 1.30),
  'Ge': Atom(Color.fromARGB(255, 102, 143, 143), 1.25),
  'As': Atom(Color.fromARGB(255, 189, 128, 227), 1.15),
  'Se': Atom(Color.fromARGB(255, 255, 161, 0), 1.15),
  'Br': Atom(Color.fromARGB(255, 166, 41, 41), 1.15),
  'Kr': Atom(Color.fromARGB(255, 92, 184, 209), 1.15),
};
