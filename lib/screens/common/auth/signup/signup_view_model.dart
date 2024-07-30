import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/models/common/role_data.dart';

class SignUpViewModel extends ChangeNotifier {
  SignUpViewModel() {
    // _selectedRole = listRole[0];
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RoleData? _selectedRole;
  RoleData? get selectedRole => _selectedRole;

  List<RoleData> listRole = [
    RoleData(roleId: 1, roleText: 'Karyawan'),
    RoleData(roleId: 2, roleText: 'Admin'),
    RoleData(roleId: 3, roleText: 'HRD'),
  ];

  bool isObscured1 = true;
  bool isObscured2 = true;

  bool _isPasswordMatch = true;
  bool get isPasswordMatch => _isPasswordMatch;

  void changeRole(RoleData newSelectedRole) {
    _selectedRole = newSelectedRole;
    notifyListeners();
  }

  void checkIsPasswordMatch() {
    _isPasswordMatch = passwordController.text == confirmPasswordController.text;
    notifyListeners();
  }

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

  Future submitRegister() {
    log('=== register form test name ${nameController.text}');
    log('=== register form test email ${emailController.text}');
    log('=== register form test nik ${nikController.text}');
    log('=== register form test pass ${passwordController.text}');
    log('=== register form test confirm pass ${confirmPasswordController.text}');
    log('=== register form test selectedroleid ${selectedRole?.roleId ?? 0}');
    return Future.value(true);
  }
}
