import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/screens/employee/notification/notification_view_model.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/screens/common/auth/splash_screen/splash_screen_view.dart';
import 'package:reimburse_rb/utility/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

NotificationAppLaunchDetails notificationAppLaunchDetails =
    const NotificationAppLaunchDetails(true);

class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;

  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
  });
}

String navigationActionId = 'id_3';
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  switch (notificationResponse.notificationResponseType) {
    case NotificationResponseType.selectedNotification:
      selectNotificationSubject.add(notificationResponse.payload ?? '');
      break;

    case NotificationResponseType.selectedNotificationAction:
      if (notificationResponse.actionId == navigationActionId) {
        selectNotificationSubject.add(notificationResponse.payload ?? '');
      }
  }
}

Future<void> inBackgroundNotification(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
  log("${message.data}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(inBackgroundNotification);

  notificationAppLaunchDetails =
      (await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails())!;

  const DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  var initializationSettings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: initializationSettingsDarwin);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      switch (notificationResponse.notificationResponseType) {
        case NotificationResponseType.selectedNotification:
          selectNotificationSubject.add(notificationResponse.payload ?? '');
          break;

        case NotificationResponseType.selectedNotificationAction:
          if (notificationResponse.actionId == navigationActionId) {
            selectNotificationSubject.add(notificationResponse.payload ?? '');
          }
      }
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => NavigationProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> mainKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _isAndroidPermissionGranted();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();
    fcmInitialize();
  }

  @override
  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
    super.dispose();
  }

  bool notificationsEnabled = false;
  RemoteMessage? notificationDetail;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  // final storage = const FlutterSecureStorage();
  final LocalStorage localStorage = LocalStorage('reimburse_rb');

  Future<void> _isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      setState(() {
        notificationsEnabled = granted;
      });
    }
  }

  Future<void> _requestPermissions() async {
    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestNotificationsPermission();
      setState(() {
        notificationsEnabled = granted ?? false;
      });
    }
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      log('receivedNotification $receivedNotification');
    });
  }

  void _configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      log('notificationDetail $notificationDetail');
      if (notificationDetail != null) {
        handleDeepLink(notificationDetail!);
      }
    });
  }

  bool checkTitleNotif(RemoteMessage message) {
    bool isValidNotif = false;
    if (message.notification != null && message.notification?.title != null) {
      isValidNotif = true;
    }
    return isValidNotif;
  }

  Future<void> _showNotification(RemoteMessage data) async {
    String imgBitMapIOS = '';
    String imgBitMapAndroid = '@mipmap/launcher_icon';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'reimburse-rb',
      'REIMBURSERB',
      channelDescription: 'ReimburseRB Notification',
      icon: imgBitMapAndroid,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      largeIcon: DrawableResourceAndroidBitmap(imgBitMapAndroid),
    );

    var iOSPlatformChannelSpecifics = imgBitMapIOS == ''
        ? const DarwinNotificationDetails()
        : DarwinNotificationDetails(attachments: <DarwinNotificationAttachment>[
            DarwinNotificationAttachment(imgBitMapIOS)
          ]);

    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      data.notification.hashCode,
      data.notification?.title,
      data.notification?.body,
      platformChannelSpecifics,
    );
  }

  void fcmInitialize() async {
    NotificationSettings? permissionIOS;

    if (Platform.isIOS) {
      permissionIOS = await _fcm.requestPermission(
          alert: true, announcement: false, badge: true, carPlay: false, sound: true);
    }

    if ((permissionIOS != null &&
                permissionIOS.authorizationStatus == AuthorizationStatus.authorized ||
            permissionIOS?.authorizationStatus == AuthorizationStatus.provisional) ||
        Platform.isAndroid) {
      _fcm.getToken().then((fcmToken) async {
        if (kDebugMode) {
          print("firebase token: $fcmToken");
        }
        var authToken = await localStorage.getItem('auth_token');

        if (authToken != null) {
          await NotificationViewModel(context: context).updateFcmToken(fcmToken ?? '');
        }
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        bool isValidNotif = checkTitleNotif(message);
        log('isValidNotif $isValidNotif');

        if (isValidNotif && notificationsEnabled) {
          setState(() {
            notificationDetail = message;
          });
          _showNotification(message);
        }
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
        log("onLaunch: $message");
        bool isValidNotif = checkTitleNotif(message);

        if (isValidNotif) {
          Timer(const Duration(seconds: 4), () {
            handleDeepLink(message);
          });
        }
      });
    }
  }

  void handleDeepLink(RemoteMessage message) {
    Navigator.of(navigatorKey.currentContext!).pushNamed('/notification');
  }

  Map<String, Widget Function(BuildContext)> routes = {
    '/splashScreen': (BuildContext context) => const SplashScreen(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReimburseRB',
      debugShowCheckedModeBanner: false,
      initialRoute: '/splashScreen',
      routes: routes,
      key: mainKey,
      navigatorKey: navigatorKey,
      theme: Provider.of<ThemeNotifier>(context).currentThemeData,
    );
  }
}
