import 'package:flutter/material.dart';
import 'package:mytodoapp/models/task.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final Function addToSelect;
  final Function removeFromSelect;
  final Function toggle;

  const TaskTile(
      {Key key,
      this.task,
      this.addToSelect,
      this.removeFromSelect,
      this.toggle})
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
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
          title: Text(
            task.content,
            maxLines: null,
            style: TextStyle(
                decoration:
                    isTicked ? TextDecoration.lineThrough : TextDecoration.none,
                color: isTicked
                    ? Theme.of(context).textTheme.headline6.color
                    : Theme.of(context).textTheme.headline6.color),
          ),
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
                  : Icon(
                      Icons.access_time_sharp,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
            ],
          ),
          onChanged: (bool newValue) {
            setState(
              () {
                isTicked = !isTicked;
              },
            );
            task.isTicked = isTicked == false ? 0 : 1;
            widget.toggle(task);
          },
        ),
      ),
    );
  }
}
