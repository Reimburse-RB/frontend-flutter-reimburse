import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/screens/common/auth/splash_screen/splash_screen_view.dart';
import 'package:reimburse_rb/utility/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
