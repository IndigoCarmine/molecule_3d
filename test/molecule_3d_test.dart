import 'package:flutter_test/flutter_test.dart';

import 'package:molecule_3d/molecule_3d.dart';
import 'package:vector_math/vector_math_64.dart';

void main() {
  //widget tests
  testWidgets('MolecularViewer', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final _controller = MolecularViewerController();
    await tester.pumpWidget(MolecularViewerDraggable(
        controller: _controller,
        child: MolecularViewer(
            atoms: [AtomObject.fromElementName("C", Vector3.zero())],
            controller: _controller)));
  });
}
