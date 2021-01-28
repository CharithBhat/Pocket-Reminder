class QuickTodo {
  String id;
  String name;
  String date;

  QuickTodo({
    this.date,
    this.id,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
    };
  }
}
