import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/module/auth/screen/splash_screen/splash_screen_view.dart';
import 'package:reimburse_rb/utility/theme.dart';

void main() {
  // runApp(const MyApp());
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ThemeNotifier(),
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

  Map<String, Widget Function(BuildContext)> routes = {
    '/splashScreen': (BuildContext context) => const SplashScreen(),
    // '/mainMenu': (BuildContext context) => const MainMenu(),
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
