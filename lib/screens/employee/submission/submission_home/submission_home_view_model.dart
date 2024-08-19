import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/modal_data.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class SubmissionHomeViewModel extends ChangeNotifier {
  SubmissionHomeViewModel({
    required this.context,
  }) {
    final userProvider = context.read<UserProvider>();
    List listReimbursementCategory = userProvider.listReimbursementCategory;
    for (ReimbursementCategoryData reimbursementCategory in listReimbursementCategory) {
      modalOptionList.add(
        ModalRegularData(
          text: 'Reimburse ${reimbursementCategory.categoryReimbursementText}',
          onTap: () {
            context.read<NavigationProvider>().navigateToFormReimbursement(
                  context: context,
                  reimbursementCategory: reimbursementCategory,
                );
          },
        ),
      );
    }

    getUserReimburse();
  }

  late TabController _tabController;
  TabController get tabController => _tabController;

  HttpService http = HttpService();
  late BuildContext context;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  String modalTitle = 'Jenis Pengajuan';
  List<ModalRegularData> modalOptionList = [];

  List listStatusTab = [
    'Semua',
    'Menunggu Diproses',
    'Sedang Diproses',
    'Diterima',
    'Ditolak',
  ];

  List<Map> listBodyTab = [
    {},
    {
      'status': [1]
    },
    {
      'status': [2]
    },
    {
      'status': [3]
    },
    {
      'status': [4]
    },
  ];

  Map _selectedBodyTab = {};
  Map get selectedBodyTab => _selectedBodyTab;

  List<ItemUserReimburseData> _listReimbursement = [];
  List<ItemUserReimburseData> get listReimbursement => _listReimbursement;

  void initTabController(TickerProvider vsync, int length) {
    _tabController = TabController(length: length, vsync: vsync);
    _tabController.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (!tabController.indexIsChanging && tabController.index != tabController.previousIndex) {
      // log('current tab index ${tabController.index}');
      _listReimbursement = [];
      _selectedBodyTab = listBodyTab[tabController.index];
      context.read<UserProvider>().setSelectedSubmissionTabIndex(tabController.index);
      getUserReimburse();

      notifyListeners();
    }
  }

  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
  }

  Future getUserReimburse() async {
    startLoading();
    notifyListeners();

    String endpoint = 'reimburse/get-user-reimburse';
    Map body = selectedBodyTab;

    await http.post(endpoint: endpoint, body: body).then((res) {
      ListUserReimburseResponse response = ListUserReimburseResponse.fromJson(res);
      if (response.success) {
        _listReimbursement.addAll(response.data ?? []);
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
