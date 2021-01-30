class ReminderTodo {
  String id;
  String title;
  int completed;
  String date;

  ReminderTodo({
    this.id,
    this.title,
    this.completed,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'date': date,
    };
  }
}
