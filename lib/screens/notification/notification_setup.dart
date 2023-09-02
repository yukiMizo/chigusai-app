import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationSetup {
  static void fcmSetup() async {
    final FirebaseMessaging fbm = FirebaseMessaging.instance;
    final FlutterLocalNotificationsPlugin flnp = FlutterLocalNotificationsPlugin();

    //for ios
    fbm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    //foreground
    //ios
    fbm.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    //android
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      flnp.initialize(const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')));
      if (notification == null) {
        return;
      }
      if (android == null) {
        return;
      }
      // 通知
      flnp.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'channel_id',
            'channel_name',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    });
    //topic設定
    fbm.subscribeToTopic("notification");
  }
}
