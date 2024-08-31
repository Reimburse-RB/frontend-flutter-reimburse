import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class DetailReimbursementViewModel extends ChangeNotifier {
  DetailReimbursementViewModel({required this.context}) {
    getDetailReimbursement();
  }

  HttpService http = HttpService();
  late BuildContext context;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  DetailReimburseData? _detailReimburseData;
  DetailReimburseData? get detailReimburseData => _detailReimburseData;

  Color? _statusColor;
  Color? get statusColor => _statusColor;

  void setStatusColor() {
    _statusColor =
        Helper(context: context).getStatusColor(statusId: detailReimburseData?.status_id);
    notifyListeners();
  }

  Future getDetailReimbursement() async {
    startLoading();
    notifyListeners();

    final userProvider = context.read<UserProvider>();

    String endpoint = 'reimburse/get-detail-reimburse';
    Map body = {
      'reimburseId': userProvider.selectedDetailReimbursementId,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      DetailReimburseResponse response = DetailReimburseResponse.fromJson(res);
      if (response.success) {
        _detailReimburseData = response.data;

        setStatusColor();

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

  Future postChangeDetailReimbursement({required int newStatusId}) async {
    startLoading();
    notifyListeners();

    final userProvider = context.read<UserProvider>();

    String endpoint = 'reimburse/change-status-reimburse';
    Map body = {
      'id': userProvider.selectedDetailReimbursementId,
      'change_status_id': newStatusId,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      ChangeStatusReimburseResponse response = ChangeStatusReimburseResponse.fromJson(res);
      if (response.success) {
        Helper(context: context).showToast(message: response.msg);
        getDetailReimbursement();
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
