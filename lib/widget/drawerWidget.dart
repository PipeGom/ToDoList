import "package:flutter/material.dart";
import "package:to_do_list/controller/taskController.dart";
import "package:to_do_list/widget/view/taskCreateView.dart";
import "package:to_do_list/widget/view/taskListView.dart";
import "package:to_do_list/widget/view/taskSearchDate.dart";
import "package:to_do_list/widget/view/taskSearchTitle.dart";
import "package:to_do_list/widget/view/taskUpcomingView.dart";

class DrawerWidget extends StatelessWidget {
  TaskListController con;

  DrawerWidget({super.key, required this.con});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          ListTile(
            contentPadding: EdgeInsets.only(bottom: 40, top: 40, left: 30),
            tileColor: Color.fromARGB(255, 253, 228, 199),
            title: const Text(
              'Hola! Qué deseas hacer hoy?',
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 136, 0),
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Añadir una tarea'),
            leading: Icon(
              Icons.add_circle,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskCreateView(controller: con),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search_outlined,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            title: const Text('Buscador'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskSearchTitle(
                      con: con,
                    ),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.inbox_outlined,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            title: const Text('Mis Tareas'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskListView(conUpdated: con),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today_outlined,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            title: const Text('Hoy'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskSearchDate(con: con),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            title: const Text('Próximo'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TaskUpcomingView(con: con),
                  ));
            },
          )
        ],
      ),
    );
  }
}
