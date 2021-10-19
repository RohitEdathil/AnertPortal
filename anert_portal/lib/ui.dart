import 'package:anert_portal/components/chooser.dart';
import 'package:flutter/material.dart';

final bg1 = Colors.grey[900];
final bg2 = Colors.grey[850];
final fg = Colors.blue;

class AnertExporter extends StatelessWidget {
  const AnertExporter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: bg1,
        body: const Center(
          child: ExportControls(),
        ),
      ),
    );
  }
}

class ExportControls extends StatefulWidget {
  const ExportControls({Key? key}) : super(key: key);

  @override
  State<ExportControls> createState() => _ExportControlsState();
}

class _ExportControlsState extends State<ExportControls> {
  Data selected = Data.ev;

  void _setChoice(int n) {
    selected = n == 0 ? Data.ev : Data.inspection;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: bg2,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DataChooser(foreground: fg, background: bg2!, callback: _setChoice),
        ],
      ),
    );
  }
}

enum Data { ev, inspection }
