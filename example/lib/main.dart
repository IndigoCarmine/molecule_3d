import 'package:flutter/material.dart';
import 'package:molecule_3d/viewer2.dart';

void main() {
  runApp(const MyApp());
}

String xyz = '''
38

C          0.01050        0.93060        0.93720
C         -0.72140        1.27510       -0.36310
C         -0.63070       -0.36390        1.42420
C         -0.07510       -1.01280       -0.84430
C         -0.77350        0.27720       -1.27390
C          1.32720       -0.48480       -0.52790
C         -0.68810       -1.35090        0.50980
C          1.37360        0.50550        0.39150
C          2.55470        1.06570        0.70470
C          3.68590        0.64040        0.12190
C         -1.75480       -2.72320        2.06270
C         -1.25910       -2.52470        0.83180
C         -1.12020       -0.57070        2.65920
C         -1.68050       -1.74710        2.97880
C         -1.83050        2.68490       -1.85390
C         -1.23240        2.47980       -0.67080
C         -1.35610        0.49590       -2.46550
C         -1.89600        1.69060       -2.75040
C          3.63840       -0.33030       -0.80120
C          2.46050       -0.87970       -1.13350
C         -0.14890       -2.21050       -1.78910
O          0.59130       -3.16350       -1.68680
C         -0.01740        1.99640        2.03070
O         -1.02620        2.59950        2.32260
H          2.63120        1.89210        1.42550
H          4.65160        1.10680        0.37990
H         -2.21980       -3.68880        2.32350
H         -1.33350       -3.34680        0.10360
H         -1.07680        0.21080        3.43310
H         -2.08350       -1.91140        3.99230
H         -2.24840        3.67570       -2.09940
H         -1.16220        3.32970        0.02370
H         -1.39360       -0.28000       -3.24330
H         -2.36900        1.86530       -3.73150
H          4.56450       -0.65970       -1.30170
H          2.45520       -1.64520       -1.92310
H         -0.93320       -2.22570       -2.57850
H          0.91330        2.20310        2.60490
''';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '9_10_Diformyltriptycene'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MolecularViewerController controller = MolecularViewerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: MolecularViewerDraggable(
                  controller: controller,
                  child: MolecularViewer(
                      atoms: loadXyz(xyz), controller: controller)),
            )
          ],
        ),
      ),
    );
  }
}
