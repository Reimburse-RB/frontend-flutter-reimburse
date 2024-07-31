import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:reimburse_rb/models/common/auth_response.dart';
import 'package:reimburse_rb/screens/common/auth/forgot_password/forgot_password_view.dart';
import 'package:reimburse_rb/screens/common/auth/signup/signup_view.dart';
import 'package:reimburse_rb/screens/employee/main_menu/main_menu_view.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class SignInViewModel extends ChangeNotifier {
  SignInViewModel({
    required this.context,
  }) {}

  HttpService http = HttpService();
  final LocalStorage localStorage = LocalStorage('reimburse_rb');
  late BuildContext context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isObscured = true;

  bool _isReadyToSubmit = false;
  bool get isReadyToSubmit => _isReadyToSubmit;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  void checkAllField() {
    _isReadyToSubmit = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

    notifyListeners();
  }

  void changeIsObscuredText() {
    isObscured = !isObscured;
    notifyListeners();
  }

  void navigateToSignUpScreen() {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const SignUpScreen(),
    ));
  }

  void navigateToForgotPasswordScreen() {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const ForgotPasswordScreen(),
    ));
  }

  void navigateToEmployeeMainMenu() {
    log('===> navigate to employee main menu');

    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const MainMenuScreen(),
    ));
  }

  void navigateToAdminMainMenu() {
    log('===> navigate to admin main menu');

    // Navigator.of(context).pushReplacement(CupertinoPageRoute(
    //   builder: (context) => const MainMenuScreen(),
    // ));
  }

  Future submitSignIn() async {
    startLoading();
    notifyListeners();

    String endpoint = 'user/login';
    Map body = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      SignInResponse response = SignInResponse.fromJson(res);
      if (response.success) {
        Helper(context: context).showToast(message: response.msg);
        localStorage.setItem('auth-token', response.token);
        localStorage.setItem('role', response.user?.role);
        localStorage.setItem(
          'is-admin-or-hrd',
          response.user?.role == 2 || response.user?.role == 3,
        );

        notifyListeners();

        if (response.user?.role == 1) {
          navigateToEmployeeMainMenu();
        } else if (response.user?.role == 2 && response.user?.role == 3) {
          navigateToAdminMainMenu();
        }
      } else {
        Helper(context: context).showToast(message: response.msg, isSuccess: false);
      }
    }).catchError((err) {
      log('===> error $endpoint $err');
      Helper(context: context).showToast(message: err.toString(), isSuccess: false);

      stopLoading();
      notifyListeners();
    });

    stopLoading();
    notifyListeners();

    return Future.value(true);
  }
}
