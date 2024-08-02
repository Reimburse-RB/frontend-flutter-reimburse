import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/screens/common/detail_reimbursement/detail_reimbursement_view.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view.dart';

class NavigationProvider extends ChangeNotifier {
  NavigationProvider() {}

  void navigateToDetailReimbursement({required BuildContext context}) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const DetailReimbursementScreen(),
    ));
  }

  void navigateToFormReimbursement({required BuildContext context}) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const SubmissionFormScreen(),
    ));
  }
}
