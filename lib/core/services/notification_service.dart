import 'package:simple_paint/core/core.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    // iOS permission

    // Android settings
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _localNotifications.initialize(initSettings);
  }

  Future<void> showNotification({String? title, String? body}) async {
    const androidDetails = AndroidNotificationDetails(
      'simple_paint_notifications_channel_id',
      'SimplePaint Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await _localNotifications.show(0, title ?? 'No Title', body ?? 'No Body', details);
  }
}
