import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/module/auth/screen/splash_screen/splash_screen_view_model.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SplashScreenViewModel>(
      create: (context) {
        return SplashScreenViewModel();
      },
      builder: (context, child) {
        return const SplashScreenView();
      },
    );
  }
}

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    // Authentication.checkAuth(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/apps_logo/logo-reimburserb.png',
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
      ),
    );
  }
}
