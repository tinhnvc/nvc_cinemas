import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    const androidInitialize =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitialize = DarwinInitializationSettings();
    const initialSettings = InitializationSettings(
      android: androidInitialize,
      iOS: iosInitialize,
    );
    await _notificationPlugin.initialize(
      initialSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {},
    );
  }

  static Future<void> showNotification(RemoteMessage message) async {
    const notiDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'default_notification_channel_id',
        'nvc_cinemas',
        channelDescription: 'Push notification in NVC Cinemas',
        enableLights: true,
        importance: Importance.max,
        priority: Priority.high,
        fullScreenIntent: true,
        styleInformation: MediaStyleInformation(
          htmlFormatContent: true,
          htmlFormatTitle: true,
        ),
      ),
      iOS: DarwinNotificationDetails(
        presentBadge: true,
      ),
    );
    await _notificationPlugin.show(
      DateTime.now().microsecond,
      '${message.data['from']}',
      message.data['type'] == 'video'
          ? 'Thông báo video'
          : 'Bấm để xem chi tiết',
      notiDetails,
      payload: message.data.toString(),
    );
  }
}
