import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/common/detail_reimbursement/detail_reimbursement_view.dart';
import 'package:reimburse_rb/screens/employee/main_menu/main_menu_view.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationProvider() {}

  void navigateToDetailReimbursement({
    required BuildContext context,
    required int id,
  }) {
    final userProvider = context.read<UserProvider>();
    userProvider.setSelectedDetailReimbursementId(id);
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const DetailReimbursementScreen(),
    ));
  }

  void navigateToFormReimbursement({
    required BuildContext context,
    required ReimbursementCategoryData reimbursementCategory,
  }) {
    final userProvider = context.read<UserProvider>();
    userProvider.setSelectedReimbursementCategoryId(reimbursementCategory);
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const SubmissionFormScreen(),
    ));
  }

  void navigateToMenuPage({
    required BuildContext context,
    required Widget page,
  }) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => page,
    ));
  }

  void navigateToMainMenuPage({required BuildContext context}) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const MainMenuScreen(),
    ));
  }
}
