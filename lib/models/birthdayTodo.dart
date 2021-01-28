class BirthdayTodo {
  String id;
  String name;
  String date;

  BirthdayTodo({
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
