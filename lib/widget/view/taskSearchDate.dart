import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_list/controller/taskController.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/widget/view/taskDetailView.dart';

class TaskSearchDate extends StatefulWidget {
  TaskListController? con;
  TaskSearchDate({super.key, required this.con}); // siempre usar el this.

  @override
  State<TaskSearchDate> createState() => _TaskSearchDateState();
}

class _TaskSearchDateState extends State<TaskSearchDate> {
  TextEditingController _textController = TextEditingController();
  List<Task>? display_list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateList();
  }

  void updateList() {
    // Obtiene la fecha actual
    DateTime currentDate = DateTime.now();

    // Filtra las tareas cuya fecha de vencimiento coincide con el día actual
    setState(() {
      if (widget.con != null && widget.con!.tasks != null) {
        display_list = widget.con!.tasks.where((task) {
          return task.deadLine.day == currentDate.day &&
              task.deadLine.month == currentDate.month &&
              task.deadLine.year == currentDate.year;
        }).toList();
      } else {
        display_list = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Esto es lo que tienes para hoy!'),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: display_list!.length,
                itemBuilder: (context, index) {
                  return ListTileTodayTasks(index, context);
                },
              ),
            )
          ],
        ));
  }

  ListTile ListTileTodayTasks(int index, BuildContext context) {
    return ListTile(
      title:
          Text('${display_list?[index].title}', style: TextStyle(fontSize: 25)),
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
                    display_list?[index].description as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Checkbox(
                    value: display_list?[index].completed,
                    onChanged: (newValue) {
                      setState(() {
                        display_list?[index].completed = newValue!;
                      });
                    }),
                IconButton(
                    onPressed: () {
                      setState(() {
                        widget.con!
                            .deleteTask(display_list?[index] as Task, context);
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
                Text(
                    ' ${display_list?[index].deadLine.day} - ${display_list?[index].deadLine.month} - ${display_list?[index].deadLine.year}'),
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
                    controller: widget.con as TaskListController,
                    task: display_list![index],
                    index: index,
                  ))),
        );
      },
    );
  }
}
