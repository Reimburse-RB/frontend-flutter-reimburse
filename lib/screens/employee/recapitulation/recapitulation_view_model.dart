import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/recapitulation_response.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/recapitulation/recapitulation_list_view.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class RecapitulationViewModel extends ChangeNotifier {
  RecapitulationViewModel({
    required this.context,
    this.isPeriodListYearScreen = false,
    this.isPeriodListMonthScreen = false,
  }) {
    getData();
  }

  HttpService http = HttpService();
  final BuildContext context;
  bool isPeriodListYearScreen = false;
  bool isPeriodListMonthScreen = false;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  List<String> _listPeriod = [];
  List<String> get listPeriod => _listPeriod;

  List<ItemUserReimburseData> _listRecapitulation = [];
  List<ItemUserReimburseData> get listRecapitulation => _listRecapitulation;

  void getData() {
    if (isPeriodListYearScreen || isPeriodListMonthScreen) {
      getPeriodList();
    } else {
      getRecapitulationList();
    }
  }

  Future getPeriodList() async {
    startLoading();
    notifyListeners();

    String? endpoint;
    Map body = {};

    final userProvider = context.read<UserProvider>();

    if (isPeriodListYearScreen) {
      endpoint = 'reimburse/get-year-recap';
    }
    if (isPeriodListMonthScreen) {
      endpoint = 'reimburse/get-month-recap';
      body['year'] = userProvider.selectedRecapitulationYear;
    }
    body['isAdmin'] = userProvider.isAdmin;

    if (endpoint != null) {
      await http.post(endpoint: endpoint, body: body).then((res) {
        RecapitulationPeriodResponse response = RecapitulationPeriodResponse.fromJson(res);
        if (response.success) {
          _listPeriod = response.data ?? [];
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
    }

    stopLoading();
    notifyListeners();
    return Future.value(true);
  }

  Future getRecapitulationList() async {
    startLoading();
    notifyListeners();

    final userProvider = context.read<UserProvider>();
    String endpoint = 'reimburse/get-user-reimburse';
    Map body = {
      'isAdmin': userProvider.isAdmin,
      'dateReimburse': userProvider.selectedRecapitulationMonth,
      // "${userProvider.selectedRecapitulationMonth} ${userProvider.selectedRecapitulationYear}",
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      ListUserReimburseResponse response = ListUserReimburseResponse.fromJson(res);
      if (response.success) {
        _listRecapitulation = response.data ?? [];
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

  void navigateToRecapitulationList() {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const RecapitulationListScreen(),
    ));
  }
}
