import 'package:flutter/material.dart';

class ChoiceBG extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color fg;
  const ChoiceBG(
      {Key? key, required this.fg, required this.icon, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: fg,
          ),
          Text(
            name,
            style: Theme.of(context).textTheme.headline5?.copyWith(color: fg),
          )
        ],
      ),
    );
  }
}
