import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TaskScreen extends StatefulWidget {
  final String title;

  const TaskScreen({Key key, this.title}) : super(key: key);
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            child: SvgPicture.asset(
              'lib/assets/checklist.svg',
              alignment: Alignment.topLeft,
            ),
          ),
        ),
      ),
    );
  }
}
