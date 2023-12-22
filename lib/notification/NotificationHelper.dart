import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';


class NotificationHelper {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitialize =
    const AndroidInitializationSettings('app_icon');
    var iOSInitialize = const DarwinInitializationSettings();
    var initializationsSettings = InitializationSettings(
        android: androidInitialize, iOS: iOSInitialize);
    // flutterLocalNotificationsPlugin.initialize(initializationsSettings, onSelectNotification: (String payload) async {
    //   try{
    //     // if(payload != null && payload.isNotEmpty) {
    //     //   MyApp.navigatorKey.currentState.push(
    //     //       MaterialPageRoute(builder: (context) => Tv(orderModel: null, orderId: int.parse(payload))));
    //     // }
    //   }catch (e) {}
    //   return;
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print(
          "onMessage: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      showNotification(message, flutterLocalNotificationsPlugin, false);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          "onOpenApp: ${message.notification!.title}/${message.notification!.body}/${message.notification!.titleLocKey}");
      try {
        if (message.notification!.titleLocKey != null &&
            message.notification!.titleLocKey!.isNotEmpty) {
          // MyApp.navigatorKey.currentState.push(
          //     MaterialPageRoute(builder: (context) => OrderDetailsScreen(orderModel: null, orderId: int.parse(message.notification.titleLocKey))));
        }
      } catch (e) {}
    });
  }

  static Future<void> showNotification(RemoteMessage message,
      FlutterLocalNotificationsPlugin fln, bool data) async {
    String? title;
    String? body;
    String? orderID;
    String? image;
    String? id;
    String? type;
    String? flag;
    String? isGold;
    String? amt;
    if (data) {
      /*String title = data.getString("title");
      String message = data.getString("message");
      boolean isBackground = data.getBoolean("is_background");
      String imageUrl = data.getString("image");
      String timestamp = data.getString("timestamp");
      String id = data.getString("id");
      String type = data.getString("type");
      String flag = data.getString("flag");
      String is_gold = data.getString("is_gold");
      String amt = data.getString("amt");
      */
      title = message.data['title'];
      body = message.data['message'];
      // _orderID = message.data['order_id'];
      id = message.data['id'];
      type = message.data['type'];
      flag = message.data['flag'];
      isGold = message.data['is_gold'];
      amt = message.data['amt'];
      image = /*(message.data['image'] != null &&
              message.data['image'].isNotEmpty)
          ? message.data['image'].startsWith('http')
              ? message.data['image']
              : '${AppConstants.BASE_URL}/storage/app/public/notification/${message.data['image']}'
          : null;*/
      message.data['image'];
    } else {
      title = message.notification!.title;
      body = message.notification!.body;
      // orderID = message.notification!.titleLocKey;
      if (Platform.isAndroid) {
        image = (message.notification!.android!.imageUrl != null &&
            message.notification!.android!.imageUrl!.isNotEmpty)
            ? message.notification!.android!.imageUrl!.startsWith('http')
            ? message.notification!.android!.imageUrl
            : message.notification!.android!.imageUrl
            : null;
      } else if (Platform.isIOS) {
        image = (message.notification!.apple!.imageUrl != null &&
            message.notification!.apple!.imageUrl!.isNotEmpty)
            ? message.notification!.apple!.imageUrl!.startsWith('http')
            ? message.notification!.apple!.imageUrl
            : message.notification!.apple!.imageUrl
            : null;
      }
    }

    if (image != null && image.isNotEmpty) {
      try {
        await showBigPictureNotificationHiddenLargeIcon(
            title!, body!, image, fln);
      } catch (e) {
        await showBigTextNotification(title!, body!, fln);
      }
    } else {
      await showBigTextNotification(title!, body!, fln);
    }
  }

  static Future<void> showTextNotification(
      String title, String body, FlutterLocalNotificationsPlugin fln) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'apnashyam',
      'apnashyam',
      // playSound: true,
      importance: Importance.max,
      priority: Priority.max,
      // sound: RawResourceAndroidNotificationSound('notification'),
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: title);
  }

  static Future<void> showBigTextNotification(
      String title, String body, FlutterLocalNotificationsPlugin fln) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
    );
    AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'apnashyam',
      'apnashyam',
      importance: Importance.max,
      styleInformation: bigTextStyleInformation,
      priority: Priority.max,
      // playSound: true,
      // sound: const RawResourceAndroidNotificationSound('notification'),
    );
    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: title);
  }

  static Future<void> showBigPictureNotificationHiddenLargeIcon(String title,
      String body, String image, FlutterLocalNotificationsPlugin fln) async {
    final String largeIconPath = await _downloadAndSaveFile(image, 'largeIcon');
    final String bigPicturePath =
    await _downloadAndSaveFile(image, 'bigPicture');
    final BigPictureStyleInformation bigPictureStyleInformation =
    BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      hideExpandedLargeIcon: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: body,
      htmlFormatSummaryText: true,
    );
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'apnashyam',
      'apnashyam',
      largeIcon: FilePathAndroidBitmap(largeIconPath),
      priority: Priority.max,
      // playSound: true,
      styleInformation: bigPictureStyleInformation,
      importance: Importance.max,
      // sound: const RawResourceAndroidNotificationSound('notification'),
    );
    final NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await fln.show(0, title, body, platformChannelSpecifics, payload: title);
  }

  static Future<String> _downloadAndSaveFile(
      String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final Response response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final File file = File(filePath);
    await file.writeAsBytes(response.data);
    return filePath;
  }
}

Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async {
  print(
      "onBackground: ${message.notification!.title}/${message.notification!.body}");
}
