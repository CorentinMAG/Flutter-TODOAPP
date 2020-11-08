import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mytodoapp/blocs/task_bloc.dart';
import 'package:mytodoapp/models/task.dart';
import 'package:mytodoapp/widgets/floatting_buttons.dart';
import 'package:mytodoapp/widgets/my_app_bar.dart';
import 'package:mytodoapp/widgets/task_tile.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key key}) : super(key: key);
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen>
    with AutomaticKeepAliveClientMixin<TaskScreen> {
  List<Task> selectedTask = [];
  TaskBloc _taskBloc = TaskBloc();

  void addToSelect(Task task) {
    setState(() {
      selectedTask.add(task);
    });
  }

  void removeFromSelect(Task task) {
    setState(() {
      selectedTask.remove(task);
    });
  }

  void clearSelected() {
    selectedTask.forEach((task) {
      _taskBloc.deleteTask(task);
    });
    setState(() {
      selectedTask.clear();
    });
  }

  @override
  void didChangeDependencies() {
    _taskBloc = TaskBloc();
    super.didChangeDependencies();
  }

  void toggleTask(Task task) {
    _taskBloc.updateTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Mes tâches du jour",
        select: selectedTask,
        onDelete: clearSelected,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<Task>>(
          stream: _taskBloc.taskStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final Task task = snapshot.data[index];
                  return TaskTile(
                    toggle: (task) => toggleTask(task),
                    task: task,
                    addToSelect: (task) => addToSelect(task),
                    removeFromSelect: (task) => removeFromSelect(task),
                  );
                },
              );
            }
            return Center(
              child: SvgPicture.asset(
                'lib/assets/checklist.svg',
                width: 500.0,
                height: 500.0,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloattingButtons(
        isNote: false,
        taskBloc: _taskBloc,
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
