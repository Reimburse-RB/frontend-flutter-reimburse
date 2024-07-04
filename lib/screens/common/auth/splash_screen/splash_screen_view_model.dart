import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/screens/common/auth/onboarding/onboarding_view.dart';

class SplashScreenViewModel extends ChangeNotifier {
  SplashScreenViewModel() {}

  static void startOnboard({required BuildContext context}) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const OnboardingScreen(),
    ));
  }
}
