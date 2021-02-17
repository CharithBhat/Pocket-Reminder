import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificationher {
  Notificationher._privateConstructor();
  
  static final Notificationher _fltrNotification = Notificationher._privateConstructor();

  // FlutterLocalNotificationsPlugin get notific{
  //   return _fltrNotification;
  // }

  FlutterLocalNotificationsPlugin instance = new FlutterLocalNotificationsPlugin();

  factory Notificationher() {
    return _fltrNotification;
  }
}


// this needs to be turned into a singleton i think