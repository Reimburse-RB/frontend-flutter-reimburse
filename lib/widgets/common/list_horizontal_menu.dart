import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/menu_data.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/card_menu_item.dart';

class ListHorizontalMenu extends StatelessWidget {
  final EdgeInsets padding;
  final MenuCategoryData menuCategory;

  const ListHorizontalMenu({
    super.key,
    required this.menuCategory,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            menuCategory.categoryTitle,
            style: Constant.mainTitleStyle,
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: menuCategory.menuList
                  .map(
                    (MenuItemData item) => Row(
                      children: [
                        CardMenuItem(menuItemData: item),
                        const SizedBox(width: 16),
                      ],
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
