import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/module/auth/screen/onboarding/onboarding_view.dart';

class SplashScreenViewModel extends ChangeNotifier {
  SplashScreenViewModel() {}

  static void startOnboard({required BuildContext context}) {
    log('asuasuasuaus');

    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const OnboardingScreen(),
    ));
  }
}
