// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/controller/taskController.dart';
import 'package:to_do_list/widget/view/taskListView.dart';

class TaskCreateView extends StatefulWidget {
  final TaskListController controller;

  TaskCreateView({super.key, required this.controller});

  @override
  State<TaskCreateView> createState() => _TaskCreateViewState();
}

class _TaskCreateViewState extends State<TaskCreateView> {
  TextEditingController _textTitulo = TextEditingController();
  TextEditingController _textDescription = TextEditingController();
  TextEditingController _dateCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear nueva tarea'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: _textTitulo,
              decoration: InputDecoration(
                  label: Text('Titulo'),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)))),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: _textDescription,
              decoration: InputDecoration(
                  label: Text('Descripción'),
                  border: UnderlineInputBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)))),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: _dateCon,
              decoration: InputDecoration(
                labelText: 'Fecha límite',
                filled: true,
                prefixIcon: Icon(Icons.calendar_today),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple)),
              ),
              readOnly: true,
              onTap: () {
                _selectDate();
              },
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    widget.controller.createTask(
                        _textTitulo, _textDescription, _dateCon, context);
                    print("Task created");
                    setState(() {});
                    if (_textTitulo.text != '' &&
                        _textDescription.text != '' &&
                        _dateCon != '') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => TaskListView(
                                    conUpdated: widget.controller,
                                  ))));
                    }
                  },
                  child: Text('Crear')),
              SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => TaskListView(
                                  conUpdated: widget.controller,
                                ))));
                  },
                  child: Text('Cancelar'))
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    // cancel returns null
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_picked != null) {
      setState(() {
        _dateCon.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
