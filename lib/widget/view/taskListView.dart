import "package:flutter/material.dart";
import "package:to_do_list/controller/taskController.dart";

class TaskListView extends StatefulWidget {
  final TaskListController controller = TaskListController();

  TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('TaskListView'));
  }
}
