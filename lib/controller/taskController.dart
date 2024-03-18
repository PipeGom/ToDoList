import 'package:to_do_list/models/task.dart';

class TaskListController {
  List<Task> tasks = [];

  TaskListController() {
    tasks = [
      Task('Task 1', false, DateTime(2024, 3, 18),
          'Cepillarle los dientes al perro'),
      Task('Task 2', true, DateTime(2024, 3, 19), 'Sacar la basura'),
      Task('Task 3', false, DateTime(2024, 3, 30), 'Hacer la cena'),
      Task('Task 3', false, DateTime(2024, 3, 30),
          'Estudiar para el examen de investigacion de operaciones, y luego ir a entrenar'),
    ];
  }

  void deleteTask(Task task) {
    // ignore: unused_local_variable
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].title == task.title) {
        tasks.removeAt(i);
        break;
      }
    }
  }
}
