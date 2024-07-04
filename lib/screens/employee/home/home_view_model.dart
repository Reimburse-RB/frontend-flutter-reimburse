import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/models/common/menu_data.dart';
import 'package:reimburse_rb/screens/common/term_condition/term_condition_view.dart';
import 'package:reimburse_rb/screens/employee/recapitulation/recapitulation_list_period_view.dart';

class HomeViewModel extends ChangeNotifier {
  final Function(int)? moveToAnotherTab;

  HomeViewModel({this.moveToAnotherTab});

  List<MenuCategoryData> listMenuCategory = [
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
          page: const TermConditionScreen(),
        ),
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-transport.png',
          title: 'Reimbursement Transportasi',
          page: const TermConditionScreen(),
        ),
      ],
    ),
  ];

  void navigateToTab(int index) {
    moveToAnotherTab!(index);
    notifyListeners();
  }

  void navigateToMenuPage({
    required BuildContext context,
    required Widget page,
    bool isSubmissionPage = false,
    int categorySubmission = 1, //1 kesehatan 2 transportasi
  }) {
    // final provider = context.read<DetectionProvider>();

    // provider.setCurrentDetectionTypeSelected(index);
    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => page),
    );
  }
}
