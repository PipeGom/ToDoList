import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_list/controller/taskController.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/widget/view/taskDetailView.dart';

class TaskUpcomingView extends StatefulWidget {
  TaskListController? con;
  TaskUpcomingView({super.key, required this.con}); // siempre usar el this.

  @override
  State<TaskUpcomingView> createState() => _TaskUpcomingViewState();
}

class _TaskUpcomingViewState extends State<TaskUpcomingView> {
  TextEditingController _textController = TextEditingController();
  List<Task>? display_list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateList();
  }

  void updateList() {
    DateTime currentDate = DateTime.now();
    //this is the function that would filter our list
    setState(() {
      if (widget.con != null && widget.con!.tasks != null) {
        display_list =
            List.from(widget.con!.tasks); // Crea una copia de la lista original
        display_list!.sort((a, b) {
          // Calcula la diferencia en días entre la fecha de vencimiento de las tareas y la fecha actual
          Duration differenceA = a.deadLine.difference(currentDate);
          Duration differenceB = b.deadLine.difference(currentDate);

          // Compara las diferencias en días entre las tareas
          return differenceA.inDays.compareTo(differenceB.inDays);
        });
      } else {
        display_list =
            []; // Inicializa display_list como una lista vacía si widget.con o widget.con.tasks es nulo
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pronto'),
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
                  return ListTileSearchedUpcomingTasks(index, context);
                },
              ),
            )
          ],
        ));
  }

  ListTile ListTileSearchedUpcomingTasks(int index, BuildContext context) {
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
                        widget.con!.deleteTask(display_list?[index] as Task);
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
