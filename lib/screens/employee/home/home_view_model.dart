import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/menu_data.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/models/employee/employee_summary_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/common/term_condition/term_condition_view.dart';
import 'package:reimburse_rb/screens/employee/recapitulation/recapitulation_list_period_view.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required this.context,
    this.moveToAnotherTab,
  }) {
    getEmployeeSummary();
    getUserReimburse();
  }

  final Function(int)? moveToAnotherTab;

  HttpService http = HttpService();
  late BuildContext context;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  List<ItemUserReimburseData> _listReimbursementActive = [];
  List<ItemUserReimburseData> get listReimbursementActive => _listReimbursementActive;

  List<MenuCategoryData> listMenuCategoryAdmin = [
    MenuCategoryData(
      categoryTitle: 'Informasi',
      menuList: [
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-syarat.png',
          title: 'Persyaratan Pengajuan',
          page: const TermConditionScreen(),
        ),
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-rekapitulasi.png',
          title: 'Rekapitulasi Reimbursement',
          page: const RecapitulationListPeriodScreen(),
        ),
      ],
    ),
    MenuCategoryData(
      categoryTitle: 'Permintaan Masuk',
      menuList: [
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-verif-akun.png',
          title: 'Verifikasi Perubahan dan Akun Baru',
          page: const RecapitulationListPeriodScreen(),
        ),
      ],
    ),
  ];

  List<MenuCategoryData> listMenuCategoryEmployee = [
    MenuCategoryData(
      categoryTitle: 'Informasi',
      menuList: [
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-syarat.png',
          title: 'Persyaratan Pengajuan',
          page: const TermConditionScreen(),
        ),
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-rekapitulasi.png',
          title: 'Rekapitulasi Reimbursement',
          page: const RecapitulationListPeriodScreen(),
        ),
      ],
    ),
    MenuCategoryData(
      categoryTitle: 'Form Pengajuan',
      menuList: [
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-health.png',
          title: 'Reimbursement Kesehatan',
          page: const SubmissionFormScreen(),
          selectedReimbursementCategory: UserProvider().listReimbursementCategory[0],
        ),
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-transport.png',
          title: 'Reimbursement Transportasi',
          page: const SubmissionFormScreen(),
          selectedReimbursementCategory: UserProvider().listReimbursementCategory[1],
        ),
      ],
    ),
  ];

  void navigateToTab(int index) {
    moveToAnotherTab!(index);
    notifyListeners();
  }

  Future getEmployeeSummary() async {
    startLoading();
    notifyListeners();

    String endpoint = 'reimburse/get-summary-reimburse';

    await http.post(endpoint: endpoint).then((res) {
      EmployeeSummaryResponse response = EmployeeSummaryResponse.fromJson(res);
      if (response.success) {
        final provider = context.read<UserProvider>();
        provider.setEmployeeSummaryData(response.data);

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

  Future getUserReimburse() async {
    startLoading();
    notifyListeners();

    String endpoint = 'reimburse/get-user-reimburse';
    Map body = {
      'status': [1, 2],
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      ListUserReimburseResponse response = ListUserReimburseResponse.fromJson(res);
      if (response.success) {
        _listReimbursementActive = response.data ?? [];
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
}
