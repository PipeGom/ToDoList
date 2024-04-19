import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/utils/mySnackBar.dart';

class TaskListController {
  FirebaseFirestore db = FirebaseFirestore.instance;
  final String collection = 'tasks';

  List<Task> tasks = [];
  List<Task>? display_list;

  TaskListController();
  List<Task> getTasks() {
    return tasks;
  }

  void createTask(
      TextEditingController title,
      TextEditingController description,
      TextEditingController deadLine,
      context,
      String? id) {
    if (title.text != '' && description.text != '' && deadLine.text != '') {
      tasks.add(Task(title.text, false, DateTime.parse(deadLine.text),
          description.text, id));

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

  // createTaskFirebase
/*
  Future<String> createTaskFirebase(Task task, context) async {
    DocumentReference response =
        // el add recibe un json y lo guarda en la base de datos.
        await db.collection(collection).add(task.toJson());
    return response.id;
  }*/

  //-------------- Create Task with FireBase ------------------
  Future<void> createTaskFirebaseWithId(Task task, context) async {
    // el add recibe un json y lo guarda en la base de datos.
    await db.collection(collection).doc(task.id).set(task.toJson());
  }

  //-------------- Update Task with FireBase ------------------
  Future<void> updateTaskFirebaseWithId(Task task, context) async {
    await db.collection(collection).doc(task.id).update(task.toJson());
  }

  void updateTask(
      Task task,
      TextEditingController title,
      TextEditingController description,
      TextEditingController deadLine,
      int index,
      context) {
    if (title.text != '' && description.text != '' && deadLine.text != '') {
      tasks[index] = Task(title.text, false, DateTime.parse(deadLine.text),
          description.text, task.id);
      MySnackbar.show(context, "Tarea editada con éxito");
    } else {
      MySnackbar.show(context, "Debes diligenciar todos los campos");
    }
  }

  //-------------- Remove Task with FireBase ------------------
  Future<void> removeTaskFirebaseWithId(String? id) async {
    await db.collection(collection).doc(id).delete();
  }

  //-------------- Get Task with FireBase ------------------
  Future<List<Task>> getTaskFirebase() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('tasks').get();
    List<DocumentSnapshot> docs = querySnapshot.docs;

    List<Task> tasks = docs.map((doc) {
      return Task(doc['title'], doc['completed'],
          DateTime.parse(doc['deadLine']), doc['description'], doc['id']);
    }).toList();

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

  List<Task> searchTask(List<Task> task, String query) {
    print(task[0]);
    return task.where((task) {
      return task.title.toLowerCase().contains(query.toLowerCase()) ||
          task.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
