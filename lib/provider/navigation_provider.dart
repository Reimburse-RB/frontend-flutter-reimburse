import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/admin/account_verification/account_verification_detail_view.dart';
import 'package:reimburse_rb/screens/common/detail_reimbursement/detail_reimbursement_view.dart';
import 'package:reimburse_rb/screens/employee/main_menu/main_menu_view.dart';
import 'package:reimburse_rb/screens/employee/profile/profile_detail/profile_detail_view.dart';
import 'package:reimburse_rb/screens/employee/recapitulation/recapitulation_list_month_view.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view.dart';
import 'package:reimburse_rb/utility/helper.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationProvider() {}

  void navigateToRecapitulationPeriodMonth({
    required BuildContext context,
    required String year,
  }) {
    final userProvider = context.read<UserProvider>();
    userProvider.setSelectedRecapitulationYear(year);

    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const RecapitulationListMonthScreen(),
    ));
  }

  void navigateToDetailAccountVerification({
    required BuildContext context,
    required int id,
    required Function(dynamic) onReturn,
  }) {
    final userProvider = context.read<UserProvider>();

    if (!userProvider.isAccountVerified) {
      Helper(context: context).alertUnverifiedAccount();
      return;
    }

    userProvider.setSelectedDetailAccountVerificationId(id);
    Navigator.of(context)
        .push(CupertinoPageRoute(
      builder: (context) => const DetailAccountVerificationScreen(),
    ))
        .then(
      ((value) {
        onReturn(value);
      }),
    );
  }

  void navigateToDetailReimbursement({
    required BuildContext context,
    required int id,
    required Function(dynamic) onReturn,
  }) {
    final userProvider = context.read<UserProvider>();

    if (!userProvider.isAccountVerified) {
      Helper(context: context).alertUnverifiedAccount();
      return;
    }

    userProvider.setSelectedDetailReimbursementId(id);
    Navigator.of(context)
        .push(CupertinoPageRoute(
      builder: (context) => const DetailReimbursementScreen(),
    ))
        .then(
      ((value) {
        onReturn(value);
      }),
    );
  }

  void navigateToFormReimbursement({
    required BuildContext context,
    required ReimbursementCategoryData reimbursementCategory,
    required Function(dynamic) onReturn,
  }) {
    final userProvider = context.read<UserProvider>();

    if (!userProvider.isAccountVerified) {
      Helper(context: context).alertUnverifiedAccount();
      return;
    }

    userProvider.setSelectedReimbursementCategoryId(reimbursementCategory);
    Navigator.of(context)
        .push(CupertinoPageRoute(
      builder: (context) => const SubmissionFormScreen(),
    ))
        .then(
      ((value) {
        onReturn(value);
      }),
    );
  }

  void navigateToProfileDetail({
    required BuildContext context,
    required Function(dynamic) onReturn,
  }) {
    Navigator.of(context)
        .push(CupertinoPageRoute(
      builder: (context) => const ProfileDetailSceen(),
    ))
        .then(
      ((value) {
        onReturn(value);
      }),
    );
  }

  void navigateToMenuPage({
    required BuildContext context,
    required Widget page,
    bool isAccountMustVerified = false,
    required Function(dynamic) onReturn,
  }) {
    final userProvider = context.read<UserProvider>();

    if (isAccountMustVerified && !userProvider.isAccountVerified) {
      Helper(context: context).alertUnverifiedAccount();
      return;
    }

    Navigator.of(context)
        .push(CupertinoPageRoute(
      builder: (context) => page,
    ))
        .then(
      ((value) {
        onReturn(value);
      }),
    );
    ;
  }

  void navigateToMainMenuPage({required BuildContext context}) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(
      builder: (context) => const MainMenuScreen(),
    ));
  }
}
