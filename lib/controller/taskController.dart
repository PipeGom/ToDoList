import 'package:flutter/cupertino.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/utils/mySnackBar.dart';

class TaskListController {
  List<Task> tasks = [];
  List<Task>? display_list;

  TaskListController() {
    tasks = [
      Task('Task 1', false, DateTime(2024, 3, 18),
          'Cepillarle los dientes al perro'),
      Task('Task 2', true, DateTime(2024, 3, 19), 'Sacar la basura'),
      Task('Task 3', false, DateTime(2024, 3, 30), 'Hacer la cena'),
      Task('Tarea Hoy', false, DateTime.now(),
          'Estudiar para el examen de investigacion de operaciones, y luego ir a entrenar'),
    ];
  }

  List<Task> getTasks() {
    return tasks;
  }

  void deleteTask(Task task, context) {
    // ignore: unused_local_variable
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].title == task.title) {
        tasks.removeAt(i);
        break;
      }
    }
    MySnackbar.show(context, "Tarea eliminada con éxito");
  }

  void createTask(
      TextEditingController title,
      TextEditingController description,
      TextEditingController deadLine,
      context) {
    if (title.text != '' && description.text != '' && deadLine.text != '') {
      tasks.add(Task(
          title.text, false, DateTime.parse(deadLine.text), description.text));

      for (Task task in tasks) {
        print(task.title);
        print(task.completed);
        print(task.deadLine);
        print(task.description);
      }
      MySnackbar.show(context, "Tarea creada con éxito");
    } else {
      MySnackbar.show(context, "Debes diligenciar todos los campos");
    }
  }

  void updateTask(
      TextEditingController title,
      TextEditingController description,
      TextEditingController deadLine,
      int index,
      context) {
    if (title.text != '' && description.text != '' && deadLine.text != '') {
      tasks[index] = Task(
          title.text, false, DateTime.parse(deadLine.text), description.text);
      MySnackbar.show(context, "Tarea editada con éxito");
    } else {
      MySnackbar.show(context, "Debes diligenciar todos los campos");
    }
  }

  List<Task> searchTask(List<Task> task, String query) {
    print(task[0]);
    return task.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase()) ||
          task.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
