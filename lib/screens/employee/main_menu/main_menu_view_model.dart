import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';

class MainMenuViewModel extends ChangeNotifier {
  MainMenuViewModel({required this.context}) {}

  BuildContext context;

  bool _statusClose = false;

  void onItemTapped(int index) {
    final userProvider = context.read<UserProvider>();
    userProvider.setSelectedMainMenuIndex(index);
  }

  void close() {
    var duration = const Duration(seconds: 2);
    Timer(duration, () {
      _statusClose = false;
      notifyListeners();
    });
  }

  Future<bool> onWillPop(BuildContext context) async {
    if (_statusClose) {
      exit(0);
    } else {
      var snackBar = SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 10),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(color: Colors.black54, borderRadius: BorderRadius.circular(4)),
          child: const Text(
            "Tekan sekali lagi untuk keluar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      _statusClose = true;
      close();
      return Future.value(false);
    }
  }
}
