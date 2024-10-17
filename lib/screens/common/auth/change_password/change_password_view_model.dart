import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/general_response.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  ChangePasswordViewModel({required this.context}) {}

  HttpService http = HttpService();
  late BuildContext context;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  bool isObscured1 = true;
  bool isObscured2 = true;

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  void checkAllField() {
    _isButtonEnabled =
        oldPasswordController.text.isNotEmpty && newPasswordController.text.isNotEmpty;
    notifyListeners();
  }

  void changeIsObscuredText1() {
    isObscured1 = !isObscured1;
    notifyListeners();
  }

  void changeIsObscuredText2() {
    isObscured2 = !isObscured2;
    notifyListeners();
  }

  Future postChangePassword() async {
    startLoading();
    notifyListeners();

    String endpoint = 'user/change-password';
    Map body = {
      'newPassword': newPasswordController.text,
      'oldPassword': oldPasswordController.text,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      GeneralResponse response = GeneralResponse.fromJson(res);
      if (response.success) {
        Navigator.of(context).pop();
        Helper(context: context).showToast(message: response.msg);
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
