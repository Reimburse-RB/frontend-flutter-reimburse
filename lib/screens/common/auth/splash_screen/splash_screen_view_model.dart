import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/common/auth/onboarding/onboarding_view.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';

class SplashScreenViewModel extends ChangeNotifier {
  SplashScreenViewModel() {}

  final LocalStorage localStorage = LocalStorage('reimburse_rb');

  void checkAuth({required BuildContext context}) {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      String token = localStorage.getItem('auth-token') ?? '';
      int? role = localStorage.getItem('role');
      bool isAdmin = localStorage.getItem('is-admin-or-hrd') ?? false;

      context.read<UserProvider>().setIsAdmin(isAdmin);
      log('===> check auth \n===> token : $token\n===> role : $role\n===> isAdmin : $isAdmin');

      if (token.isNotEmpty) {
        if (role != null) {
          (role == Constant.employeeRoleId ||
                  role == Constant.adminRoleId ||
                  role == Constant.hrdRoleId)
              ? context.read<NavigationProvider>().navigateToMainMenuPage(context: context)
              : Helper(context: context).showToast(
                  message: 'Role tidak valid',
                  isSuccess: false,
                );
        }
      } else {
        NavigationProvider().navigateToOnboardScreen(context: context);
      }
    });
  }
}
