import 'package:flutter/cupertino.dart';

class SignUpViewModel extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isObscured1 = true;
  bool isObscured2 = true;

  SignUpViewModel() {}

  void onChangeIsObscuredText1() {
    isObscured1 = !isObscured1;
    notifyListeners();
  }

  void onChangeIsObscuredText2() {
    isObscured2 = !isObscured2;
    notifyListeners();
  }

  void navigateToLoginScreen({required BuildContext context}) {
    Navigator.of(context).pop();
  }
}
