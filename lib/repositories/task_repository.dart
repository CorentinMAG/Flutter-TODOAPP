import 'package:mytodoapp/models/task.dart';
import 'package:mytodoapp/providers/task_provider.dart';

class TaskRepository {
  final taskProvider = TaskProvider();

  Future<List<Task>> fetchAllTask() => taskProvider.getAllTasks();

  Future<int> createTask(Task task) => taskProvider.newTask(task);

  Future<int> updatetask(Task task) => taskProvider.updateTask(task);

  Future<int> deletetask(Task task) => taskProvider.deleteTask(task);
}
