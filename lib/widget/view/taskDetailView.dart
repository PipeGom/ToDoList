import 'package:flutter/material.dart';
import 'package:to_do_list/controller/taskController.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/widget/view/taskListView.dart';

class TaskDetailView extends StatefulWidget {
  final TaskListController controller;
  final Task task;
  final int index;

  TaskDetailView(
      {super.key,
      required this.controller,
      required this.task,
      required this.index});

  @override
  State<TaskDetailView> createState() => _TaskDetailViewState();
}

class _TaskDetailViewState extends State<TaskDetailView> {
  TextEditingController _textTitulo = TextEditingController();
  TextEditingController _textDescription = TextEditingController();
  TextEditingController _dateCon = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textTitulo.text = widget.task.title;
    _textDescription.text = widget.task.description;
    _dateCon.text = widget.task.deadLine.toString().split(' ')[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar tarea'),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: _textTitulo,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.edit),
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
                        suffixIcon: Icon(Icons.edit),
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
                      suffixIcon: Icon(Icons.edit_calendar),
                      border: UnderlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
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
                          widget.controller.updateTask(_textTitulo,
                              _textDescription, _dateCon, widget.index);
                          print("Task created");
                          setState(() {});
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => TaskListView(
                                        conUpdated: widget.controller,
                                      ))));
                        },
                        child: Text('Actualizar')),
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
          ),
        ),
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
