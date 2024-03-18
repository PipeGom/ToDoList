class Task {
  late String title;
  late bool completed;
  late DateTime deadLine;
  late String description;

  Task(this.title, this.completed, this.deadLine, this.description);

  Task.empty();
}
