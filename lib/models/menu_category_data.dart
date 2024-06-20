import 'package:reimburse_rb/models/menu_item_data.dart';

class MenuCategoryData {
  MenuCategoryData({
    required this.categoryTitle,
    required this.menuList,
  });
  late final String categoryTitle;
  late final List<MenuItemData> menuList;
}
