class ReminderTodo {
  String id;
  String title;
  String description;
  int completed;
  String date;

  ReminderTodo({
    this.id,
    this.title,
    this.description,
    this.completed,
    this.date,
  });

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title': title,
      'description': description,
      'completed' : completed,
      'date' : date,
    };
  }
}
