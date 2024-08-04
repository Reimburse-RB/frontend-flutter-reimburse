import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class SubmissionFormViewModel extends ChangeNotifier {
  SubmissionFormViewModel({
    required this.context,
  }) {
    getListPurposeOption();
    getListDetailOption();
    addDetailCost();
  }

  HttpService http = HttpService();
  BuildContext context;
  List<PurposeOptionData>? _listPurposeOption;
  List<PurposeOptionData>? get listPurposeOption => _listPurposeOption;

  List<DetailCostOptionData>? _listDetailOption;
  List<DetailCostOptionData>? get listDetailOption => _listDetailOption;

  List<Map> _listBodyDetailCost = [];
  List<Map> get listBodyDetailCost => _listBodyDetailCost;

  PurposeOptionData? _selectedPurpose;
  PurposeOptionData? get selectedPurpose => _selectedPurpose;

  TextEditingController totalCostController = TextEditingController();

  double _totalCost = 0;
  double get totalCost => _totalCost;

  Map _bodySubmission = {};
  Map get bodySubmission => _bodySubmission;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  Future getListPurposeOption() async {
    startLoading();
    notifyListeners();

    String endpoint = 'reimburse/get-list-purpose-option';

    await http.post(endpoint: endpoint).then((res) {
      PurposeOptionResponse response = PurposeOptionResponse.fromJson(res);
      if (response.success) {
        _listPurposeOption = response.data;

        notifyListeners();
      } else {
        Helper(context: context).showToast(message: response.msg, isSuccess: false);
      }
    }).catchError((err) {
      log('===> error $endpoint $err');
      Helper(context: context).showToast(message: err.toString(), isSuccess: false);

      stopLoading();
      notifyListeners();
    });

    stopLoading();
    notifyListeners();
    return Future.value(true);
  }

  Future getListDetailOption() async {
    startLoading();
    notifyListeners();

    String endpoint = 'reimburse/get-list-detail-title-option';

    await http.post(endpoint: endpoint).then((res) {
      DetailCostOptionResponse response = DetailCostOptionResponse.fromJson(res);
      if (response.success) {
        _listDetailOption = response.data;

        notifyListeners();
      } else {
        Helper(context: context).showToast(message: response.msg, isSuccess: false);
      }
    }).catchError((err) {
      log('===> error $endpoint $err');
      Helper(context: context).showToast(message: err.toString(), isSuccess: false);

      stopLoading();
      notifyListeners();
    });

    stopLoading();
    notifyListeners();
    return Future.value(true);
  }

  Future changePurpose({
    PurposeOptionData? newSelectedPurpose,
  }) {
    _selectedPurpose = newSelectedPurpose;
    _bodySubmission['purpose_id'] = selectedPurpose?.purpose_id;
    notifyListeners();

    return Future.value(true);
  }

  Future addDetailCost() {
    _listBodyDetailCost.add({
      "detail_title_id": null,
      "detail_title_other_text": null,
      "detail_family_id": null,
      "detail_cost": 0,
      "detail_date": null,
      "description": null
    });
    notifyListeners();

    return Future.value(true);
  }

  Future removeDetailCost({required int index}) {
    _listBodyDetailCost.removeAt(index);
    notifyListeners();

    return Future.value(true);
  }
}
