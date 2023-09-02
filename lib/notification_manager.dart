import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  static final flnp = FlutterLocalNotificationsPlugin();

  static Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await flnp.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation = flnp.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await androidImplementation?.requestPermission();
    }
  }

  static InitializationSettings initializeLocNotification() {
    //現在時刻設定
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("Asia/Tokyo"));
    //権限設定
    const DarwinInitializationSettings initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: false,
    );
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('notification_icon');
    if (Platform.isAndroid) {
      flnp.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.requestPermission();
    }

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initSettingsIOS,
    );

    return initializationSettings;
  }

  //ローカル通知予約解除
  static Future<void> cancelLocNotification(String id) async {
    await flnp.cancel(id.hashCode);
  }

  //ローカル通知の予約
  static Future<void> registerLocNotification({
    required String id,
    required int day,
    required int hour,
    required int minute,
    required String title,
    required String message,
  }) async {
    //日時指定
    var date = tz.TZDateTime(tz.local, 2023, 9, day, hour, minute);
    //var date = tz.TZDateTime(tz.local, 2023, 8, 31, hour, minute);
    //var date = tz.TZDateTime(tz.local, 2023, 8, 31, 1, 51);
    //通知設定
    try {
      await flnp.zonedSchedule(
        id.hashCode,
        title,
        message,
        date,
        payload: "payload",
        NotificationDetails(
          android: AndroidNotificationDetails(
            '千種祭',
            '千種祭',
            importance: Importance.max,
            priority: Priority.high,
            ongoing: true,
            styleInformation: BigTextStyleInformation(message),
            icon: 'notification_icon',
          ), //iosは設定事項がほぼないためアンドロイドのみの設定
        ),
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    flnp.initialize(const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher')));

    if (notification == null) {
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
  }
}
