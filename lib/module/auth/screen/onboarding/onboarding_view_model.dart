import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reimburse_rb/module/auth/model/onboard_data.dart';
import 'package:reimburse_rb/module/auth/screen/signin/signin_view.dart';

class OnboardingViewModel extends ChangeNotifier {
  bool statusClose = false;
  int currentPage = 0;
  final PageController pageBoardController = PageController(initialPage: 0);
  List<OnboardData> onboardDataList = [];

  OnboardingViewModel() {
    List tempData = [
      {
        'image': 'assets/onboarding/onboarding_1.png',
        'desc': 'Selamat Datang di Reimbursa! Aplikasi Pengajuan Reimbursement RB Group'
      },
      {
        'image': 'assets/onboarding/onboarding_2.png',
        'desc': 'Lakukan Pengajuan Dimanapun dan Kapanpun dengan Mudah!'
      },
      {
        'image': 'assets/onboarding/onboarding_3.png',
        'desc': 'Pantau Status Keberhasilan Pengajuan Anda'
      },
    ];
    for (var i = 0; i < tempData.length; i++) {
      onboardDataList.add(OnboardData.fromJson(tempData[i]));
    }
  }

  void close() {
    var duration = const Duration(seconds: 2);
    Timer(duration, () {
      statusClose = false;
      notifyListeners();
    });
  }

  Future<bool> onBoardingClose({required BuildContext context}) {
    if (statusClose == true) {
      exit(0);
    }
    var snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25, vertical: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
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
    statusClose = true;
    notifyListeners();
    close();
    return Future.value(false);
  }

  void onPageChanged(int value) {
    currentPage = value;
    notifyListeners();
  }

  void onTapNextPage({required BuildContext context}) {
    if (currentPage < onboardDataList.length - 1) {
      pageBoardController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
    if (currentPage == onboardDataList.length - 1) {
      Navigator.of(context).push(CupertinoPageRoute(
        builder: (context) => const SignInScreen(),
      ));
    }

    notifyListeners();
  }

  void onTapPreviouskPage({required BuildContext context}) {
    if (currentPage > 0) {
      pageBoardController.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
    if (currentPage == onboardDataList.length - 1) {
      // Navigator.of(context).push(CupertinoPageRoute(
      //   builder: (context) => const LoginScreen(),
      // ));
    }
    notifyListeners();
  }
}
