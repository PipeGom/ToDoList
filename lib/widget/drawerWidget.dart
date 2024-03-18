import "package:flutter/material.dart";

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 255, 248, 240),
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
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.search_outlined,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            title: const Text('Buscador'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.inbox_outlined,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            title: const Text('Bandeja de entrada'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today_outlined,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            title: const Text('Hoy'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_month_outlined,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            title: const Text('Próximo'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.filter_list_alt,
              color: Color.fromARGB(255, 255, 136, 0),
            ),
            title: const Text('Filtros y Etiquetas'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
