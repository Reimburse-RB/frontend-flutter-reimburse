import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/module/auth/screen/signup/signup_view.dart';

class SignInViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscured = true;
  SignInViewModel() {}

  void onChangeIsObscuredText() {
    isObscured = !isObscured;
    notifyListeners();
  }

  void navigateToSignUpScreen({required BuildContext context}) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const SignUpScreen(),
    ));
  }

  static void onCallBackLogin({required BuildContext context}) {
    // Navigator.of(context).push(CupertinoPageRoute(
    //   builder: (context) => const MainMenu(),
    // ));
  }
}
