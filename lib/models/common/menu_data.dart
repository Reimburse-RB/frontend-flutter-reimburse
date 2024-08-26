import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';

class MenuCategoryData {
  MenuCategoryData({
    required this.categoryTitle,
    required this.menuList,
  });
  late final String categoryTitle;
  late final List<MenuItemData> menuList;
}

class MenuItemData {
  MenuItemData({
    required this.assetImage,
    required this.title,
    required this.page,
    this.selectedReimbursementCategory,
    this.menuIndex,
  });
  late final String assetImage;
  late final String title;
  late final Widget page;
  final int? menuIndex;
  late final ReimbursementCategoryData? selectedReimbursementCategory;
}
