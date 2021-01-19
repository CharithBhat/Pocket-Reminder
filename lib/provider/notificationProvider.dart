import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notificationher {
  FlutterLocalNotificationsPlugin _fltrNotification = new FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get notific{
    return _fltrNotification;
  }
}