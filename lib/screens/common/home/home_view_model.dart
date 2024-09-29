import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/admin/admin_summary_response.dart';
import 'package:reimburse_rb/models/common/menu_data.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/models/employee/employee_summary_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/admin/account_verification/account_verification_view.dart';
import 'package:reimburse_rb/screens/common/term_condition/term_condition_view.dart';
import 'package:reimburse_rb/screens/common/home/home_view.dart';
import 'package:reimburse_rb/screens/common/notification/notification_view_model.dart';
import 'package:reimburse_rb/screens/common/profile/profile_view_model.dart';
import 'package:reimburse_rb/screens/common/recapitulation/recapitulation_list_year_view.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required this.context,
  }) {
    ProfileViewModel(context: context).getProfile().then((value) {
      getFcmToken();
      getData();
    });
  }

  @override
  void dispose() {
    _tokenStream?.cancel();
    super.dispose();
  }

  HttpService http = HttpService();
  late BuildContext context;

  String fcmToken = '';
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  StreamSubscription? _tokenStream;

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
          page: const RecapitulationListYearScreen(),
          isAccountMustVerified: true,
        ),
      ],
    ),
    MenuCategoryData(
      categoryTitle: 'Permintaan Masuk',
      menuList: [
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-reimbursement.png',
          title: 'Reimbursement',
          page: const HomeScreen(),
          menuIndex: Constant.reimburseMenuindex,
        ),
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-verif-akun.png',
          title: 'Verifikasi Perubahan dan Akun Baru',
          page: const AccountVerificationListScreen(),
          isAccountMustVerified: true,
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
          page: const RecapitulationListYearScreen(),
          isAccountMustVerified: true,
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
          isAccountMustVerified: true,
        ),
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-transport.png',
          title: 'Reimbursement Transportasi',
          page: const SubmissionFormScreen(),
          selectedReimbursementCategory: UserProvider().listReimbursementCategory[1],
          isAccountMustVerified: true,
        ),
      ],
    ),
  ];

  void getData() {
    bool isAdmin = context.read<UserProvider>().isAdmin;
    if (isAdmin) {
      getAdminHrdSummary();
    } else {
      getEmployeeSummary();
      getUserReimburse();
    }
  }

  Future<void> getFcmToken() async {
    _tokenStream = _fcm.onTokenRefresh.listen((fcmToken) async {
      if (kDebugMode) {
        print("firebase token: $fcmToken");
      }
      await NotificationViewModel(context: context).updateFcmToken(fcmToken);
    });
  }

  Future getAdminHrdSummary() async {
    final userProvider = context.read<UserProvider>();
    if (!userProvider.isAccountVerified) {
      return;
    }

    startLoading();
    notifyListeners();

    String endpoint = 'reimburse/get-current-status-active';

    await http.post(endpoint: endpoint).then((res) {
      AdminSummaryResponse response = AdminSummaryResponse.fromJson(res);
      if (response.success) {
        userProvider.setAdminSummaryData(response.data);

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

  Future getEmployeeSummary() async {
    final userProvider = context.read<UserProvider>();
    if (!userProvider.isAccountVerified) {
      return;
    }

    startLoading();
    notifyListeners();

    String endpoint = 'reimburse/get-summary-reimburse';

    await http.post(endpoint: endpoint).then((res) {
      EmployeeSummaryResponse response = EmployeeSummaryResponse.fromJson(res);
      if (response.success) {
        userProvider.setEmployeeSummaryData(response.data);

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
    final userProvider = context.read<UserProvider>();
    if (!userProvider.isAccountVerified) {
      return;
    }

    startLoading();
    notifyListeners();

    String endpoint = 'reimburse/get-user-reimburse';
    Map body = {
      'status': [1, 2],
      'isAdmin': context.read<UserProvider>().isAdmin,
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
