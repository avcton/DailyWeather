import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHandler {
  static final NotificationHandler _notificationHandler =
      NotificationHandler._internal();
  static final onNotifications = BehaviorSubject<String?>();

  NotificationHandler._internal();

  factory NotificationHandler() {
    return _notificationHandler;
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Android Initialization
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: ((payload) async {
      onNotifications.add(payload);
    }));
  }

  Future<void> showScheduledNotification(
      int id, String title, String body, tz.TZDateTime scheduled) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title, // title
      body, // description
      scheduled, // 2 Seconds
      const NotificationDetails(
          // Android Details
          android: AndroidNotificationDetails(
        'main_channel',
        'Main Channel',
        channelDescription: "avcton",
        importance: Importance.max,
        priority: Priority.max,
      )),

      // Time Interpretaion
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
