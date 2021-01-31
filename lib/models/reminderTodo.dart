class ReminderTodo {
  String id;
  String title;
  int completed;
  String date;
  String remindDate;
  String remindTime;

  ReminderTodo({
    this.id,
    this.title,
    this.completed,
    this.date,
    this.remindDate,
    this.remindTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
      'date': date,
      'remindDate': remindDate,
      'remindTime': remindTime,
    };
  }
}
