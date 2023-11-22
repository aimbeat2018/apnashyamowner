import 'dart:io';
import 'package:apnashyamowner/constant/get_di.dart' as di;
import 'package:apnashyamowner/controller/homeController.dart';
import 'package:apnashyamowner/screens/bookings/bookings_screen.dart';
import 'package:apnashyamowner/screens/userAuth/login_screen.dart';
import 'package:apnashyamowner/utils/themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'constant/PushNotificationService.dart';
import 'constant/globalFunction.dart';
import 'constant/routes.dart';

Future<void> main() async {
  // Shared Preferences Intialize
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences.getInstance().then((instance) {
  //   instance == AppProvider().loadPage();
  //   runApp(ChangeNotifierProvider(
  //       create: (context) => AppProvider(), child: const MyApp()));
  //   SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // });
  if (GlobalFunctions.isMobilePhone()) {
    HttpOverrides.global = MyHttpOverrides();
  }
  await di.init();

  FirebaseMessaging.onBackgroundMessage(myForgroundMessageHandler);
  runApp(const MyApp());

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()!
      .requestPermission();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // To Load Screen Where it is login/logout or not
    // var provider = context.read<AppProvider>();
    // provider.loadPage();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var provider = context.read<AppProvider>();
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(340, 780),
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Apna Shyam Owner',
        theme: MyTheme.lighttheme,
        home: Get.find<HomeController>().getUserToken() == ""
            ? const LoginScreen()
            : const BookingsScreen(),
        onGenerateRoute: (settings) => generateRoute(settings, context),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
