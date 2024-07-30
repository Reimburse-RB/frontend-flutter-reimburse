import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:reimburse_rb/screens/common/auth/onboarding/onboarding_view.dart';
import 'package:reimburse_rb/screens/common/auth/signin/signin_view_model.dart';
import 'package:reimburse_rb/utility/helper.dart';

class SplashScreenViewModel extends ChangeNotifier {
  SplashScreenViewModel() {}

  final LocalStorage localStorage = LocalStorage('reimburse_rb');

  void checkAuth({required BuildContext context}) {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      String token = localStorage.getItem('auth-token') ?? '';
      int? role = localStorage.getItem('role');

      if (token.isNotEmpty) {
        if (role != null) {
          (role == 1)
              ? SignInViewModel(context: context).navigateToEmployeeMainMenu()
              : (role == 2 || role == 3)
                  ? SignInViewModel(context: context).navigateToEmployeeMainMenu()
                  : Helper(context: context).showToast(
                      message: 'Role tidak valid',
                      isSuccess: false,
                    );
        }
      } else {
        startOnboard(context: context);
      }
    });
  }

  static void startOnboard({required BuildContext context}) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const OnboardingScreen(),
    ));
  }
}
