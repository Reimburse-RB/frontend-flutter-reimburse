import 'dart:async';

import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  ForgotPasswordViewModel() {}

  TextEditingController emailController = TextEditingController();

  late Timer _timer;

  bool _isEmailEverSent = false;
  bool get isEmailEverSent => _isEmailEverSent;

  int _counter = 60;
  int get counter => _counter;

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  void startTimer() {
    _counter = 60;
    _isEmailEverSent = true;
    _isButtonEnabled = false;
    notifyListeners();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        _counter--;
      } else {
        _isButtonEnabled = true;
        _timer.cancel();
      }
      notifyListeners();
    });
  }

  void resendCode() {
    if (_isButtonEnabled) {
      // Implement resend code logic here
      startTimer();
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
