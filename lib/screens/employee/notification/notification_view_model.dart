import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class NotificationViewModel extends ChangeNotifier {
  NotificationViewModel() {
    getNotificationList();
  }

  HttpService http = HttpService();
  late BuildContext context;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  Future getNotificationList() async {
    startLoading();
    notifyListeners();

    String endpoint = 'notification/get-list-notification';

    await http.post(endpoint: endpoint).then((res) {
      log('response notification $res');
      // AdminSummaryResponse response = AdminSummaryResponse.fromJson(res);
      // if (response.success) {
      //   userProvider.setAdminSummaryData(response.data);

      //   notifyListeners();
      // } else {
      //   Helper(context: context).showToast(message: response.msg, isSuccess: false);
      // }
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

  Future updateFcmToken(String fcmToken) async {
    String endpoint = 'user/change-fcm-token';
    Map body = {
      'fcmToken': fcmToken,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {}).catchError((err) {
      log('===> error $endpoint $err');
      Helper(context: context).showToast(message: err.toString(), isSuccess: false);
    });

    return Future.value(true);
  }
}
