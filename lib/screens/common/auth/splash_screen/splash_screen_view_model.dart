import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';

class SplashScreenViewModel extends ChangeNotifier {
  SplashScreenViewModel() {}

  void checkAuth({required BuildContext context}) {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      String token = localStorage.getItem('auth-token') ?? '';
      String? roleId = localStorage.getItem('role');
      bool isAdmin = localStorage.getItem('is-admin-or-hrd') == true.toString();

      context.read<UserProvider>().setIsAdmin(isAdmin);
      log('===> check auth \n===> token : $token\n===> role : $roleId\n===> isAdmin : $isAdmin');

      if (token.isNotEmpty) {
        if (roleId != null) {
          (roleId == Constant.employeeRoleId.toString() ||
                  roleId == Constant.adminRoleId.toString() ||
                  roleId == Constant.hrdRoleId.toString())
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
