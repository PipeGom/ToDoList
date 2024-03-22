import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_list/controller/taskController.dart';
import 'package:to_do_list/models/task.dart';
import 'package:to_do_list/widget/view/taskDetailView.dart';

class TaskSearchTitle extends StatefulWidget {
  TaskListController? con;
  TaskSearchTitle({super.key, required this.con}); // siempre usar el this.

  @override
  State<TaskSearchTitle> createState() => _TaskSearchTitleState();
}

class _TaskSearchTitleState extends State<TaskSearchTitle> {
  TextEditingController _textController = TextEditingController();
  List<Task>? display_list;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateList('');
  }

  void updateList(String value) {
    //this is the function that would filter our list
    setState(() {
      if (widget.con != null && widget.con!.tasks != null) {
        display_list = widget.con!.tasks
            .where((element) =>
                element.title!.toLowerCase().contains(value.toLowerCase()))
            .toList();
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
          title: Text('Buscar tarea'),
        ),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 60),
                  Expanded(
                      child: TextField(
                    decoration: InputDecoration(labelText: 'Titulo'),
                    onChanged: (value) => updateList(value),
                  )),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.search_outlined)),
                  SizedBox(width: 30),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: display_list!.length,
                itemBuilder: (context, index) {
                  return ListTileSearchedTasks(index, context);
                },
              ),
            )
          ],
        ));
  }

  ListTile ListTileSearchedTasks(int index, BuildContext context) {
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
