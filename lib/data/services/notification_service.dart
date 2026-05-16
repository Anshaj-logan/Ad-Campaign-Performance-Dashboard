import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {

  final FlutterLocalNotificationsPlugin
  flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  bool isEnabled = true;

  Future<void> init() async {

    const androidSettings =
    AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings =
    InitializationSettings(
      android: androidSettings,
    );

    await flutterLocalNotificationsPlugin
        .initialize(settings);

    /// ANDROID 13+ PERMISSION
    await flutterLocalNotificationsPlugin

        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()

        ?.requestNotificationsPermission();
  }

  Future<void> showNotification({

    required String title,

    required String body,

  }) async {

    if (!isEnabled) return;

    const androidDetails =
    AndroidNotificationDetails(

      'anomaly_channel',

      'Anomaly Alerts',

      channelDescription:
      'Anomaly detection alerts',

      importance: Importance.max,

      priority: Priority.high,

      playSound: true,
    );

    const notificationDetails =
    NotificationDetails(
      android: androidDetails,
    );

    await flutterLocalNotificationsPlugin
        .show(
      DateTime.now()
          .millisecondsSinceEpoch ~/ 1000,

      title,

      body,

      notificationDetails,
    );
  }

  void toggleNotifications(
      bool value,
      ) {

    isEnabled = value;
  }
}