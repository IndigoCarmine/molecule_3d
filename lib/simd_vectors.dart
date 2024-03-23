import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:vector_math/vector_math_64.dart';
import 'package:vector_math/vector_math_lists.dart';

class SIMDVector3List {
  Float32x4List x;
  Float32x4List y;
  Float32x4List z;

  int _length;

  SIMDVector3List(this.x, this.y, this.z, this._length);

  factory SIMDVector3List.fromVector3List(Vector3List vector3List) {
    var x = Float32x4List(vector3List.length ~/ 4 + 1);
    var y = Float32x4List(vector3List.length ~/ 4 + 1);
    var z = Float32x4List(vector3List.length ~/ 4 + 1);
    final inputx = vector3List;
    return SIMDVector3List(x, y, z, vector3List.length);
  }

  Vector3List toVector3List() {
    var vector3List = Vector3List(x.length);
    for (var i = 0; i < x.length; i++) {
      // vector3List.setValues(i, x[i], y[i], z[i]);
    }
    return vector3List;
  }

  get length => x.length;

  // SIMDVector3List operator +(SIMDVector3List other) {
  //   return SIMDVector3List(
  //     x + other.x,
  //     y + other.y,
  //     z + other.z,
  //   );
  // }
}
