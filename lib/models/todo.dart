class Todo {
  String id;
  String title;
  String description;
  bool completed;
  DateTime date;

  Todo({
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
