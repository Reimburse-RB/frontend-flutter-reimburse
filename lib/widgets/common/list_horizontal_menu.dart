import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/menu_category_data.dart';
import 'package:reimburse_rb/models/menu_item_data.dart';
import 'package:reimburse_rb/utility/constant.dart';

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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: Constant.semiBoldText,
            ),
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
                        MenuItem(menuItemData: item),
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

class MenuItem extends StatelessWidget {
  final MenuItemData menuItemData;

  const MenuItem({Key? key, required this.menuItemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Constant.greenMoreVeryLight,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              menuItemData.assetImage,
              width: 40,
              height: 40,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 80,
            child: Text(
              menuItemData.title,
              style: const TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
