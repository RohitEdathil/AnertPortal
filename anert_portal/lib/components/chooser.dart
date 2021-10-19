import 'package:anert_portal/components/choice_background.dart';
import 'package:flutter/material.dart';

class DataChooser extends StatefulWidget {
  final Color background;
  final Color foreground;
  final Function(int) callback;
  const DataChooser(
      {Key? key,
      required this.background,
      required this.foreground,
      required this.callback})
      : super(key: key);

  @override
  _DataChooserState createState() => _DataChooserState();
}

class _DataChooserState extends State<DataChooser> {
  int selected = 0;
  bool first = true;

  void _switch() {
    setState(() {
      selected = selected == 0 ? 1 : 0;
      widget.callback(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _switch,
          child: Container(
            color: Colors.transparent,
            height: 200,
            width: 400,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ChoiceBG(
                    fg: widget.foreground,
                    icon: Icons.power_outlined,
                    name: "EV Site"),
                ChoiceBG(
                    fg: widget.foreground,
                    icon: Icons.search,
                    name: "Inspection")
              ],
            ),
          ),
        ),
        TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            tween: Tween<double>(
                begin: selected.toDouble(), end: selected == 0 ? 1.0 : 0.0),
            builder: (context, val, child) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 200 * val),
                  Container(
                    decoration: BoxDecoration(
                      color: widget.foreground,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 200,
                    width: 200,
                    child: Stack(
                      children: [
                        Opacity(
                          opacity: 1 - val,
                          child: ChoiceBG(
                            fg: widget.background,
                            icon: Icons.power_outlined,
                            name: "EV Site",
                          ),
                        ),
                        Opacity(
                          opacity: val,
                          child: ChoiceBG(
                            fg: widget.background,
                            icon: Icons.search,
                            name: "Inspection",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ],
    );
  }
}
