class Reminder{
  String id;
  String title;
  String date;

  Reminder({this.date,this.id,this.title});

  Map<String, dynamic> toMapConvert(){
    return {
      'id' : id,
      'title': title,
      'date' : date,
    };
  }
}