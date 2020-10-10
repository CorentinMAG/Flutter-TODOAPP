import 'package:mytodoapp/models/task.dart';
import 'package:mytodoapp/repositories/repository.dart';
import 'package:rxdart/rxdart.dart';

class TaskBloc {
  final _repository = Repository();
  PublishSubject<List<Task>> _taskFetcher = PublishSubject<List<Task>>();

  Stream<List<Task>> get taskStream => _taskFetcher.stream;

  TaskBloc() {
    fetchAllTasks();
  }

  void fetchAllTasks() async {
    List<Task> tasks = await _repository.fetchAllTask();
    if (tasks.isEmpty) {
      _taskFetcher.sink.add(null);
    } else {
      _taskFetcher.sink.add(tasks);
    }
  }

  void addTask(Task task) async {
    int value = await _repository.createTask(task);
    fetchAllTasks();
  }

  void updateTask(Task task) async {
    int value = await _repository.updatetask(task);
    fetchAllTasks();
  }

  void deleteTask(Task task) async {
    int value = await _repository.deletetask(task);
    fetchAllTasks();
  }

  void dispose() {
    _taskFetcher.close();
  }
}
