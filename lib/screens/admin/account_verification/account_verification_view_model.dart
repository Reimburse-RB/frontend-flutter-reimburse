import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/admin/account_verification_response.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class AccountVerificationViewModel extends ChangeNotifier {
  AccountVerificationViewModel({
    required this.context,
    this.isDetailScreen = false,
  }) {
    getData();
  }

  HttpService http = HttpService();
  late BuildContext context;
  bool isDetailScreen = false;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  ProfileData? _detailAccount;
  ProfileData? get detailAccount => _detailAccount;

  List<AccountVerificationData> _listAccountVerification = [];
  List<AccountVerificationData> get listAccountVerification => _listAccountVerification;

  void getData() {
    if (!isDetailScreen) getAccountVerificationList();
    if (isDetailScreen) getDetailAccountVerification();
  }

  Future getAccountVerificationList() async {
    startLoading();
    notifyListeners();

    String endpoint = 'user/get-user-verification';

    await http.post(endpoint: endpoint).then((res) {
      AccountVerificationResponse response = AccountVerificationResponse.fromJson(res);
      if (response.success) {
        _listAccountVerification = response.data ?? [];
        notifyListeners();
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

  Future getDetailAccountVerification() async {
    startLoading();
    notifyListeners();

    String endpoint = 'user/get-detail-user-verification';
    Map body = {
      'userId': context.read<UserProvider>().selectedDetailAccountVerificationId,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      ProfileResponse response = ProfileResponse.fromJson(res);
      if (response.success) {
        _detailAccount = response.data;
        notifyListeners();
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

  Future postVerification() async {
    startLoading();
    notifyListeners();

    String endpoint = 'user/verification-account';
    Map body = {
      'userId': context.read<UserProvider>().selectedDetailAccountVerificationId,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      ProfileResponse response = ProfileResponse.fromJson(res);
      if (response.success) {
        Helper(context: context).showToast(message: response.msg, isSuccess: true);
        getData();
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
