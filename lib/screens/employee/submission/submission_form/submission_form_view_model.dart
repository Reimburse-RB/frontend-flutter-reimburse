import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/form_reimbursement_data.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class SubmissionFormViewModel extends ChangeNotifier {
  SubmissionFormViewModel({
    required this.context,
  }) {
    getProfile();
    getListPurposeOption();
    getListDetailOption();
    addDetailCost();
  }

  HttpService http = HttpService();
  BuildContext context;
  List<PurposeOptionData>? _listPurposeOption;
  List<PurposeOptionData>? get listPurposeOption => _listPurposeOption;

  ProfileData? _profile;
  ProfileData? get profile => _profile;

  List<DetailCostOptionData>? _listDetailOption;
  List<DetailCostOptionData>? get listDetailOption => _listDetailOption;

  List<CardDetailSubmissionData> _listControllerDetailCost = [];
  List<CardDetailSubmissionData> get listControllerDetailCost => _listControllerDetailCost;

  List<Map> _listBodyDetailCost = [];
  List<Map> get listBodyDetailCost => _listBodyDetailCost;

  PurposeOptionData? _selectedPurpose;
  PurposeOptionData? get selectedPurpose => _selectedPurpose;

  TextEditingController nameController = TextEditingController();
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

  Future getProfile() async {
    startLoading();
    notifyListeners();

    String endpoint = 'user/get-profile';

    await http.post(endpoint: endpoint).then((res) {
      ProfileResponse response = ProfileResponse.fromJson(res);
      if (response.success) {
        final provider = context.read<UserProvider>();
        provider.setProfileData(response.data);

        _profile = response.data;
        nameController.text = profile?.name ?? '';
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
    _listControllerDetailCost.add(
      CardDetailSubmissionData(
        dateController: TextEditingController(),
        costController: TextEditingController(),
        descriptionController: TextEditingController(),
      ),
    );
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
    _listControllerDetailCost.removeAt(index);
    _listBodyDetailCost.removeAt(index);
    notifyListeners();

    return Future.value(true);
  }

  Future onChangeDetailTitle({required int index, required DetailCostOptionData newValue}) {
    _listControllerDetailCost[index].selectedDetailTitle = newValue;
    _listBodyDetailCost[index]['detail_title_id'] = newValue.detail_title_id;

    log('===> ochange detail title $listBodyDetailCost');
    notifyListeners();

    return Future.value(true);
  }

  Future onChangeFamilyMember({required int index, required FamilyMemberData newValue}) {
    _listControllerDetailCost[index].selectedFamilyMember = newValue;
    _listBodyDetailCost[index]['detail_family_id'] = newValue.family_status_id;

    log('===> ochange detail title $listBodyDetailCost');
    notifyListeners();

    return Future.value(true);
  }

  Future onChangeOtherDetailTitle({required int index, required String newValue}) {
    _listControllerDetailCost[index].otherDetailTitleController?.text = newValue;
    _listBodyDetailCost[index]['detail_title_other_text'] = newValue;

    log('===> ochange description $listBodyDetailCost');
    notifyListeners();

    return Future.value(true);
  }

  Future onChangeDate({required int index}) async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = now.subtract(const Duration(days: 30));
    final DateTime lastDate = now;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedDate != null) {
      _listControllerDetailCost[index].selectedDateTime = pickedDate;
      _listControllerDetailCost[index].dateController?.text =
          DateFormat('dd/MM/yyyy').format(pickedDate);
      _listBodyDetailCost[index]['detail_date'] = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
    log('===> ochange date $listBodyDetailCost');
    notifyListeners();

    return Future.value(true);
  }

  Future onEditingCompleteCost({required int index}) {
    _totalCost = 0;
    listControllerDetailCost.forEach((element) {
      _totalCost +=
          double.tryParse((listControllerDetailCost[index].costController?.text) ?? '0') ?? 0;
    });

    totalCostController.text = Helper(context: context).formatCurrency(
      amount: totalCost,
      symbol: '',
    );
    _listBodyDetailCost[index]['detail_cost'] =
        double.tryParse(listControllerDetailCost[index].costController?.text ?? '0') ?? 0;

    log('===> oneditingcompletecost $listBodyDetailCost\ntotal cost $totalCost');
    notifyListeners();

    return Future.value(true);
  }

  Future onChangeDescription({required int index, required String newValue}) {
    _listControllerDetailCost[index].descriptionController?.text = newValue;
    _listBodyDetailCost[index]['description'] = newValue;

    log('===> ochange description $listBodyDetailCost');
    notifyListeners();

    return Future.value(true);
  }
}
