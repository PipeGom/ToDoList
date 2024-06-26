import "package:flutter/material.dart";

import "package:to_do_list/controller/taskController.dart";
import "package:to_do_list/models/task.dart";
import "package:to_do_list/widget/drawerWidget.dart";
import "package:to_do_list/widget/view/taskCreateView.dart";
import "package:to_do_list/widget/view/taskDetailView.dart";

class TaskListView extends StatefulWidget {
  late TaskListController? conUpdated;

  TaskListView({super.key, this.conUpdated});

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late TaskListController _con;
  bool _hasTasks = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.conUpdated == null) {
      _con = TaskListController();
    } else {
      _con = widget.conUpdated!;
    }
  }

  @override
  Widget build(BuildContext context) {
    _hasTasks = _con.tasks.isNotEmpty;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskCreateView(
                        controller: _con,
                      )));
        },
      ),
      drawer: SafeArea(
        child: DrawerWidget(
          con: _con,
        ),
      ),
      appBar: AppBar(
        title: Text('Mis Tareas'),
      ),
      body: _hasTasks ? taskList() : noTasksImage(),
    );
  }

  Widget taskList() {
    return FutureBuilder<List<Task>>(
      future: _con.getTaskFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Task> tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              int day = task.deadLine.day;
              int year = task.deadLine.year;
              int month = task.deadLine.month;
              return this.tasks(task, day, month, year, context, index);
            },
          );
        }
      },
    );
  }

  ListTile tasks(Task task, int day, int month, int year, BuildContext context,
      int index) {
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
                    maxLines: null,
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
                        _con.deleteTask(task, context);
                        _con.removeTaskFirebaseWithId(task.id);
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
        setState(() {});
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: ((context) => TaskDetailView(
                    controller: _con,
                    task: task,
                    index: index,
                  ))),
        );
      },
    );
  }

  Widget noTasksImage() {
    return Center(
      child: Image.asset(
        'lib/assets/images/checknull.png',
        width: 200,
        height: 200,
      ),
    );
  }
}
