class BirthdayTodo {
  String id;
  String name;
  String date;
  String birthDate;

  BirthdayTodo({
    this.date,
    this.id,
    this.name,
    this.birthDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date,
      'birthDate': birthDate,
    };
  }
}
