import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_boilerplate_starter/core/constants/notification_constants.dart';
import 'package:flutter_boilerplate_starter/core/log/logger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.getToken().then((token) {
      Logger.info('Got firebase token: $token');
    });

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        AndroidInitializationSettings androidInitializationSettings =
            AndroidInitializationSettings('notifications_icon');

        var initializationSettingsIOS = IOSInitializationSettings(
          requestSoundPermission: false,
          requestBadgePermission: false,
          requestAlertPermission: false,
        );

        var initializationSettings = InitializationSettings(
            androidInitializationSettings, initializationSettingsIOS);

        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();

        await flutterLocalNotificationsPlugin
            .initialize(initializationSettings);

        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          NotificationConstants.CHANNEL_ID,
          NotificationConstants.CHANNEL_NAME,
          NotificationConstants.CHANNEL_DESCRIPTION,
          importance: Importance.Max,
          priority: Priority.High,
        );

        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          message['notification']['title'],
          message['notification']['body'],
          platformChannelSpecifics,
        );

        Logger.info('Showed notifications ${message['notification']['title']}');
      },
      onLaunch: (Map<String, dynamic> message) async {
        Logger.info('Launched push notification service $message');
      },
      onResume: (Map<String, dynamic> message) async {
        Logger.info('Resumed push notification service $message');
      },
    );
  }
}
