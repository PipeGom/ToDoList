import 'package:intl/intl.dart';

class Task {
  static int _counter = 0;
  String? id;
  late String title;
  late bool completed;
  late DateTime deadLine;
  late String description;

  // Cada vez que se cree una tarea el id se incrementa pero si asignamos el id
  // en el contador no aumenta esto se usa para pasar la tarea actualizada a la funcion
  // que crea y actuliza la tarea en base de datos
  Task(this.title, this.completed, this.deadLine, this.description, [this.id]) {
    if (id == null) {
      _counter++;
      this.id = _counter.toString();
    }
  }

  Task.empty();

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
    deadLine = json['deadLine'].toDate();
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'deadLine': dateFormat.format(deadLine),
      'description': description,
    };
  }
}
