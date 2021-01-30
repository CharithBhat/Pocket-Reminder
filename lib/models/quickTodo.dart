class QuickTodo {
  String id;
  String name;
  String date;
  int completed;

  QuickTodo({
    this.date,
    this.id,
    this.name,
    this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'completed' : completed,
    };
  }
}
