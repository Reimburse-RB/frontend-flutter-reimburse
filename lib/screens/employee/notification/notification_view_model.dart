import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/notification_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class NotificationViewModel extends ChangeNotifier {
  NotificationViewModel({
    required this.context,
  }) {
    getNotificationList();
  }

  HttpService http = HttpService();
  late BuildContext context;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  List<ItemNotificationData> _listNotification = [];
  List<ItemNotificationData> get listNotification => _listNotification;

  Future getNotificationList() async {
    final userProvider = context.read<UserProvider>();
    if (!userProvider.isAccountVerified) {
      return;
    }
    startLoading();
    notifyListeners();

    String endpoint = 'notification/get-list-notification';

    await http.post(endpoint: endpoint).then((res) {
      log('response notification $res');
      ListNotificationResponse response = ListNotificationResponse.fromJson(res);
      if (response.success) {
        _listNotification = response.data;

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
