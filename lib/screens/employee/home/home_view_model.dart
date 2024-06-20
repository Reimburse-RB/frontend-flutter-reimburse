import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/menu_category_data.dart';
import 'package:reimburse_rb/models/menu_item_data.dart';

class HomeViewModel extends ChangeNotifier {
  final Function(int) moveToAnotherTab;

  HomeViewModel({required this.moveToAnotherTab});

  // List<Map> categoryMenuList = [
  //   {
  //     'category_title': 'Informasi',
  //     'menu_list': [
  //       {
  //         'asset_image': 'assets/menu/icon-menu-syarat.png',
  //         'title': 'Persyaratan Pengajuan',
  //       },
  //       {
  //         'asset_image': 'assets/menu/icon-menu-rekapitulasi.png',
  //         'title': 'Rekapitulasi Reimbursement',
  //       },
  //     ],
  //   },
  //   {
  //     'category_title': 'Form Pengajuan',
  //     'menu_list': [
  //       {
  //         'asset_image': 'assets/menu/icon-menu-health.png',
  //         'title': 'Reimbursement Kesehatan',
  //       },
  //       {
  //         'asset_image': 'assets/menu/icon-menu-transport.png',
  //         'title': 'Reimbursement Transportasi',
  //       },
  //     ],
  //   },
  // ];

  List<MenuCategoryData> listMenuCategory = [
    MenuCategoryData(
      categoryTitle: 'Informasi',
      menuList: [
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-syarat.png',
          title: 'Persyaratan Pengajuan',
        ),
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-rekapitulasi.png',
          title: 'Rekapitulasi Reimbursement',
        ),
      ],
    ),
    MenuCategoryData(
      categoryTitle: 'Form Pengajuan',
      menuList: [
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-health.png',
          title: 'Reimbursement Kesehatan',
        ),
        MenuItemData(
          assetImage: 'assets/menu/icon-menu-transport.png',
          title: 'Reimbursement Transportasi',
        ),
      ],
    ),
  ];

  void navigateToTab(int index) {
    moveToAnotherTab(index);
    notifyListeners();
  }
}
