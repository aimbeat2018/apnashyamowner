import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../main.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
FirebaseMessaging messaging = FirebaseMessaging.instance;

backgroundMessage(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print(
      'notification(${notificationResponse.id}) action tapped: ${notificationResponse.actionId} with payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

class PushNotificationService {
  final BuildContext context;
  final Function? updateHome;

  PushNotificationService({required this.context, this.updateHome});

  Future initialise() async {
    iOSPermission();
    messaging.getToken().then((token) async {
      // CUR_USERID = await getPrefrence(ID);
      // if (CUR_USERID != null && CUR_USERID != "")
      //   _registerToken(token, context);
    });

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    /*const IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings();
    const MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    const InitializationSettings initializationSettings =
        const InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS); */
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        /* didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );*/
      },
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationPayload(notificationResponse.payload!, context);

            break;
          case NotificationResponseType.selectedNotificationAction:
            print(
                "notification-action-id--->${notificationResponse.actionId}==${notificationResponse.payload}");

            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: backgroundMessage,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      var data = message.notification!;
      print("rider:$data");

      var title = data.title.toString();
      var body = data.body.toString();
      var image = message.data['image'] ?? '';
      var type = '';
      type = message.data['type'] ?? '';

      if (image != "") {
        generateImageNotication(title, body, image, type);
      } else {
        generateSimpleNotication(title, body, type);
      }
    });
  }

  void iOSPermission() async {
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _registerToken(String? token, BuildContext context) async {
    // var parameter = {USER_ID: CUR_USERID, FCM_ID: token};
    // apiBaseHelper
    //     .postAPICall(updateFcmApi, parameter, context)
    //     .then((getdata) {}, onError: (error) {
    //   //setSnackbar(error.toString());
    // });
  }

  static Future<String> _downloadAndSaveImage(
      String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(Uri.parse(url));

    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  /* DarwinNotificationDetails darwinNotificationDetails =
    const DarwinNotificationDetails(
  categoryIdentifier: "",
); */

  Future<void> generateImageNotication(
      String title, String msg, String image, String type) async {
    var largeIconPath = await _downloadAndSaveImage(image, 'largeIcon');
    var bigPicturePath = await _downloadAndSaveImage(image, 'bigPicture');
    var bigPictureStyleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(bigPicturePath),
        hideExpandedLargeIcon: true,
        contentTitle: title,
        htmlFormatContentTitle: true,
        summaryText: msg,
        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '1', 'apna-shyam',
        channelDescription: 'apna-shyam',
        playSound: true,
        icon: "@mipmap/ic_launcher",
        sound: const RawResourceAndroidNotificationSound('notification'),
        largeIcon: FilePathAndroidBitmap(largeIconPath),
        styleInformation: bigPictureStyleInformation);
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(sound: 'notification.aiff');
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, msg, platformChannelSpecifics, payload: type);
  }

  Future<void> generateSimpleNotication(
      String title, String msg, String type) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '1',
      'apna-shyam',
      channelDescription: 'apna-shyam',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      // icon: "@mipmap/ic_launcher",
      sound: RawResourceAndroidNotificationSound('notification'),
    );
    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(sound: 'notification.aiff');
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: darwinNotificationDetails);
    await flutterLocalNotificationsPlugin
        .show(0, title, msg, platformChannelSpecifics, payload: type);
  }
}

selectNotificationPayload(String? payload, BuildContext context) async {
  if (payload != null) {
    List<String> pay = payload.split(",");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyApp(),
      ),
    );
  }
}

Future<dynamic> myForgroundMessageHandler(RemoteMessage message) async {
  return Future<void>.value();
}
