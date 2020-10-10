import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mytodoapp/widgets/floatting_buttons.dart';
import 'package:mytodoapp/widgets/my_app_bar.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key key}) : super(key: key);
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Mes tâches du jour",
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
      floatingActionButton: FloattingButtons(
        isNote: false,
      ),
    );
  }
}
