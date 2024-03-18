import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskCreateView extends StatefulWidget {
  const TaskCreateView({super.key});

  @override
  State<TaskCreateView> createState() => _TaskCreateViewState();
}

class _TaskCreateViewState extends State<TaskCreateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('Creating page'),
    );
  }
}
