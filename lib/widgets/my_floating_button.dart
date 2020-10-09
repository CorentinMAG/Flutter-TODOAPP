import 'package:flutter/material.dart';

class MyFloatingButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color color;
  final String heroTag;

  const MyFloatingButton(
      {Key key, this.onPressed, this.icon, this.color, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      child: FloatingActionButton(
        heroTag: heroTag,
        child: Icon(
          icon,
          color: color,
          size: 50.0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
