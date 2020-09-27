import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            child: SvgPicture.asset('lib/assets/checklist.svg'),
          ),
        ),
      ),
    );
  }
}
