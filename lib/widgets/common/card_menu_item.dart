import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/menu_data.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardMenuItem extends StatelessWidget {
  final MenuItemData menuItemData;

  const CardMenuItem({Key? key, required this.menuItemData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.read<NavigationProvider>();
    final userProvider = context.read<UserProvider>();
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        if (menuItemData.selectedReimbursementCategory != null) {
          userProvider
              .setSelectedReimbursementCategoryId(menuItemData.selectedReimbursementCategory!);
        }
        if (menuItemData.menuIndex != null) {
          userProvider.setSelectedMainMenuIndex(menuItemData.menuIndex!);
        } else {
          navigationProvider.navigateToMenuPage(context: context, page: menuItemData.page);
        }
      },
      child: Container(
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
      ),
    );
  }
}
