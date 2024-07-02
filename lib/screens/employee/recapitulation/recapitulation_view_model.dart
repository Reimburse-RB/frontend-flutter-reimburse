import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reimburse_rb/screens/employee/recapitulation/recapitulation_list_view.dart';

class RecapitulationViewModel extends ChangeNotifier {
  RecapitulationViewModel({required this.context}) {}

  final BuildContext context;

  void navigateToRecapitulationList() {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const RecapitulationListScreen(),
    ));
  }
}
