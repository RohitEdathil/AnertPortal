import 'dart:convert';
import 'dart:html';

import 'package:anert_portal/components/chooser.dart';
import 'package:anert_portal/data/generator.dart';
import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

final bg1 = Colors.grey[900];
final bg2 = Colors.grey[850];
final fg = Colors.blue;
final fg2 = Colors.blue[100];

class AnertExporter extends StatelessWidget {
  const AnertExporter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1,
      floatingActionButton: FloatingActionButton(
        onPressed: auth().signOut,
        child: Icon(
          Icons.power_settings_new_rounded,
          color: fg,
        ),
        backgroundColor: bg1,
      ),
      body: const Center(
        child: ExportControls(),
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
  Status status = Status.choosing;
  List<int>? file;
  void _setChoice(int n) {
    selected = n == 0 ? Data.ev : Data.inspection;
    setState(() {
      status = Status.choosing;
    });
  }

  void _handle() {
    if (status == Status.choosing) {
      setState(() {
        status = Status.generating;
      });
      generator(selected == Data.ev ? "EvSite" : "Inspection").then((value) {
        setState(() {
          status = Status.ready;
        });
        file = value;
      });
    } else if (status == Status.ready) {
      final content = base64Encode(file!);
      AnchorElement(
          href:
              "data:application/octet-stream;charset=utf-16le;base64,$content")
        ..setAttribute(
            "download", "${selected == Data.ev ? "EvSite" : "Inspection"}.xlsx")
        ..click();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bg2,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DataChooser(foreground: fg, background: bg2!, callback: _setChoice),
            GenerateButton(callback: _handle, status: status),
          ],
        ),
      ),
    );
  }
}

class GenerateButton extends StatefulWidget {
  final void Function() callback;
  final Status status;
  const GenerateButton({
    Key? key,
    required this.callback,
    required this.status,
  }) : super(key: key);

  @override
  _GenerateButtonState createState() => _GenerateButtonState();
}

class _GenerateButtonState extends State<GenerateButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.callback,
      child: Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(top: 15),
          width: 400,
          decoration:
              BoxDecoration(color: fg, borderRadius: BorderRadius.circular(10)),
          child: Text(
            widget.status == Status.choosing
                ? "Generate"
                : widget.status == Status.ready
                    ? "Download"
                    : "...",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5!.copyWith(color: bg1),
          )),
    );
  }
}

enum Data { ev, inspection }
enum Status { choosing, generating, ready }
