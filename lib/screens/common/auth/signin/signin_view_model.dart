import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/auth_response.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/common/auth/forgot_password/forgot_password_view.dart';
import 'package:reimburse_rb/screens/common/auth/signup/signup_view.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class SignInViewModel extends ChangeNotifier {
  SignInViewModel({
    required this.context,
  }) {
    getFcmToken();
  }

  HttpService http = HttpService();
  final LocalStorage localStorage = LocalStorage('reimburse_rb');
  late BuildContext context;

  String? fcmToken;

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

  Future getFcmToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();

    log('fcm token $fcmToken');
    return Future.value(true);
  }

  Future submitSignIn() async {
    if (fcmToken == null) {
      Helper(context: context).showToast(
        message: Constant.defaultErrorMessage + " Harap coba lagi",
        isSuccess: false,
      );
      getFcmToken();
      return;
    }

    startLoading();
    notifyListeners();

    String endpoint = 'user/login';
    Map body = {
      'email': emailController.text,
      'password': passwordController.text,
      'fcm_token': fcmToken,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      SignInResponse response = SignInResponse.fromJson(res);
      if (response.success) {
        Helper(context: context).showToast(message: response.msg);

        bool isAdmin = response.user?.role == Constant.adminRoleId ||
            response.user?.role == Constant.hrdRoleId;

        localStorage.setItem('auth-token', response.token);
        localStorage.setItem('role', response.user?.role);
        localStorage.setItem('is-admin-or-hrd', isAdmin);

        context.read<UserProvider>().setIsAdmin(isAdmin);
        context.read<NavigationProvider>().navigateToMainMenuPage(context: context);
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
