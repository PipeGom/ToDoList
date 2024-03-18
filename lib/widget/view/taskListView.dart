import "package:flutter/material.dart";

import "package:to_do_list/controller/taskController.dart";
import "package:to_do_list/models/task.dart";
import "package:to_do_list/widget/drawerWidget.dart";
import "package:to_do_list/widget/view/taskDetailView.dart";

class TaskListView extends StatefulWidget {
  TaskListView({super.key});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  final TaskListController _con = TaskListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        drawer: const SafeArea(
          child: DrawerWidget(),
        ),
        appBar: AppBar(
          title: Text('ToDoList'),
        ),
        body: taskList());
  }

  Widget taskList() {
    return ListView.builder(
        itemCount: _con.tasks.length,
        itemBuilder: (context, index) {
          Task task = _con.tasks[index];
          int day = task.deadLine.day;
          int year = task.deadLine.year;
          int month = task.deadLine.month;
          return ListTile(
            title: Text('${task.title}', style: TextStyle(fontSize: 25)),
            subtitle: Container(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Descripción: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          task.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Checkbox(
                          value: task.completed,
                          onChanged: (newValue) {
                            setState(() {
                              task.completed = newValue!;
                              print(task.completed);
                            });
                          }),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              _con.deleteTask(task);
                            });
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Fecha límite: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(' $day - $month - $year'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => TaskDetailView(task: task))));
            },
          );
        });
  }
}
