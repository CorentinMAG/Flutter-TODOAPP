import 'package:flutter/material.dart';
import 'package:mytodoapp/models/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final Function addToSelect;
  final Function removeFromSelect;

  const TaskTile({Key key, this.task, this.addToSelect, this.removeFromSelect})
      : super(key: key);
  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isSelected = false;
  bool isTicked;
  @override
  void initState() {
    isTicked = widget.task.isTicked == 0 ? false : true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    return InkWell(
      onLongPress: () {
        setState(
          () {
            isSelected = !isSelected;
            isSelected
                ? widget.addToSelect(task)
                : widget.removeFromSelect(task);
          },
        );
      },
      child: CheckboxListTile(
        title: Text(task.content),
        value: isTicked,
        activeColor: Colors.greenAccent,
        secondary: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            isSelected
                ? Icon(
                    Icons.check_circle,
                    color: Colors.black,
                  )
                : Icon(Icons.access_time_sharp),
          ],
        ),
        onChanged: (bool newValue) {
          setState(() {
            isTicked = !isTicked;
          });
        },
      ),
    );
  }
}
