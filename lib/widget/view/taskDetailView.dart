import 'package:flutter/material.dart';
import 'package:to_do_list/controller/taskController.dart';
import 'package:to_do_list/models/task.dart';

class TaskDetailView extends StatefulWidget {
  final Task task;

  TaskDetailView({super.key, required this.task});

  @override
  State<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<TaskDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar'),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.task.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
