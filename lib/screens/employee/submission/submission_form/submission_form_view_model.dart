import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/form_reimbursement_data.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';
import 'package:reimburse_rb/utility/image_picker_handler.dart';

class SubmissionFormViewModel extends ChangeNotifier with ImagePickerListener {
  SubmissionFormViewModel({
    required this.context,
  }) {
    getProfile();
    getListPurposeOption();
    getListDetailOption();
    initRequestBody();
  }

  HttpService http = HttpService();
  BuildContext context;

  late ImagePickerHandler imagePicker;

  List<PurposeOptionData>? _listPurposeOption;
  List<PurposeOptionData>? get listPurposeOption => _listPurposeOption;

  ProfileData? _profile;
  ProfileData? get profile => _profile;

  List<DetailCostOptionData>? _listDetailOption;
  List<DetailCostOptionData>? get listDetailOption => _listDetailOption;

  final List<CardDetailSubmissionData> _listControllerDetailCost = [];
  List<CardDetailSubmissionData> get listControllerDetailCost => _listControllerDetailCost;

  final List<File> _listAttachmentImageFile = [];
  List<File> get listAttachmentImageFile => _listAttachmentImageFile;

  final List<String> _listAttachmentImageBase64 = [];
  List<String> get listAttachmentImageBase64 => _listAttachmentImageBase64;

  final List<Map> _listBodyDetailCost = [];
  List<Map> get listBodyDetailCost => _listBodyDetailCost;

  PurposeOptionData? _selectedPurpose;
  PurposeOptionData? get selectedPurpose => _selectedPurpose;

  TextEditingController nameController = TextEditingController();
  TextEditingController totalCostController = TextEditingController();
  TextEditingController otherPurposeController = TextEditingController();

  double _totalCost = 0;
  double get totalCost => _totalCost;

  final Map _bodySubmission = {};
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

        addDetailCost();

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

    final userProvider = context.read<UserProvider>();

    String endpoint = 'reimburse/get-list-purpose-option';
    Map body = {
      'category_reimbursement_id':
          userProvider.selectedReimbursementCategory?.categoryReimbursementId,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
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
    final userProvider = context.read<UserProvider>();

    String endpoint = 'reimburse/get-list-detail-title-option';
    Map body = {
      'category_reimbursement_id':
          userProvider.selectedReimbursementCategory?.categoryReimbursementId,
    };
    await http.post(endpoint: endpoint, body: body).then((res) {
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

  bool checkFormCompleteness() {
    // Cek kondisi khusus untuk purpose_id dan purpose_other_text
    bool purposeCondition = (bodySubmission.containsKey('purpose_id') &&
            bodySubmission['purpose_id'] != null &&
            bodySubmission['purpose_id'] != 1) ||
        (bodySubmission.containsKey('purpose_other_text') &&
            bodySubmission['purpose_other_text'] != null &&
            bodySubmission['purpose_other_text'] != '');

    // Cek kondisi khusus untuk detail_title_id dan detail_title_other_text
    bool detailCondition = true;

    if (bodySubmission.containsKey('detail_reimburse') &&
        bodySubmission['detail_reimburse'] is List) {
      for (var detail in bodySubmission['detail_reimburse']) {
        bool titleCondition = (detail.containsKey('detail_title_id') &&
                detail['detail_title_id'] != null &&
                detail['detail_title_id'] != 1) ||
            (detail.containsKey('detail_title_other_text') &&
                detail['detail_title_other_text'] != null &&
                detail['detail_title_other_text'] != '');

        bool familyCondition =
            detail.containsKey('detail_family_id') && detail['detail_family_id'] != null;

        bool costCondition = detail.containsKey('detail_cost') &&
            detail['detail_cost'] != null &&
            detail['detail_cost'] != 0;

        bool dateCondition = detail.containsKey('detail_date') &&
            detail['detail_date'] != null &&
            detail['detail_date'].toString().isNotEmpty;

        // Jika salah satu kondisi gagal, hentikan loop dan tandai sebagai tidak valid
        if (!titleCondition || !familyCondition || !costCondition || !dateCondition) {
          detailCondition = false;
          break;
        }
      }
    }

    // Cek semua key, kecuali yang memiliki kondisi khusus
    bool allFieldsComplete = bodySubmission.entries.every((entry) {
      if (entry.key == 'purpose_id' || entry.key == 'purpose_other_text') {
        return true;
      }
      if (entry.key == 'detail_reimburse') {
        return true;
      }
      if (entry.key == 'image') {
        return entry.value.isNotEmpty;
      }
      return entry.value != null;
    });

    // Mengembalikan hasil akhir
    return allFieldsComplete && purposeCondition && detailCondition;
  }

  Future postUploadSubmission() async {
    _bodySubmission['purpose_other_text'] =
        otherPurposeController.text.isNotEmpty ? otherPurposeController.text : null;

    if (bodySubmission['purpose_other_text'] != null &&
        bodySubmission['purpose_other_text'] != '') {
      // default value when other purpose field is filled
      _bodySubmission['purpose_id'] = 1;
    }

    _bodySubmission['image'] = listAttachmentImageBase64;

    _bodySubmission['detail_reimburse'] = listBodyDetailCost;

    log('submission form checking \nbody : $bodySubmission');

    if (!checkFormCompleteness()) {
      log('submission form checking : INCOMPLETE');
      Helper(context: context).showToast(
        isSuccess: false,
        message: Constant.warningFormIncomplete,
        seconds: 5,
      );
    } else {
      log('submission form checking : COMPLETE');
      startLoading();
      notifyListeners();

      String endpoint = 'reimburse/add-reimburse';

      await http.post(endpoint: endpoint, body: bodySubmission).then((res) {
        AddReimburseResponse response = AddReimburseResponse.fromJson(res);
        if (response.success) {
          Navigator.pop(context);
          Helper(context: context).showToast(message: response.msg);
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
    }
    return Future.value(true);
  }

  Future initRequestBody() {
    totalCostController.text = Helper(context: context).formatCurrency(
      amount: totalCost,
      symbol: '',
    );

    final userProvider = context.read<UserProvider>();

    _bodySubmission['category_reimbursement_id'] =
        userProvider.selectedReimbursementCategory?.categoryReimbursementId;
    return Future.value(true);
  }

  Future onChangePurpose({
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
        selectedFamilyMember: profile?.family_member_data.first,
      ),
    );
    _listBodyDetailCost.add({
      "detail_title_id": null,
      "detail_title_other_text": '',
      "detail_family_id": profile?.family_member_data.first.id,
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

  onTapAddImage({required AnimationController animationController}) {
    imagePicker = ImagePickerHandler(this, animationController);
    imagePicker.init(context);
    imagePicker.showDialog(context);
  }

  addImage({required File imageFile}) {
    String imageBase64 = base64Encode(imageFile.readAsBytesSync());

    listAttachmentImageBase64.add(imageBase64);
    listAttachmentImageFile.add(imageFile);

    notifyListeners();
  }

  removeImage({required int index}) {
    listAttachmentImageBase64.removeAt(index);
    listAttachmentImageFile.removeAt(index);

    notifyListeners();
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
    _listBodyDetailCost[index]['detail_family_id'] = newValue.id;

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
    final DateTime? pickedDate = await Helper(context: context).onChangeDate(context: context);

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
      _totalCost = totalCost + (double.tryParse((element.costController?.text) ?? '0') ?? 0);
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

  @override
  void userImage(File image) {
    String base64Image = base64Encode(image.readAsBytesSync());
    String fileName = image.path.split("/").last;
    // Uint8List byestsImg = const Base64Decoder().convert(base64Image);

    addImage(imageFile: image);

    log('===> imagepicker base64 cropped $base64Image');
    log('===> imagepicker fileName $fileName');
  }
}
