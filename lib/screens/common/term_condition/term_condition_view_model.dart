import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/term_condition_response.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class TermConditionViewModel extends ChangeNotifier {
  TermConditionViewModel({required this.context}) {
    getTnc();
    // for (Map termCondition in tempTermConditionList) {
    //   termConditionList.add(TermConditionData.fromJson(termCondition));
    // }
  }

  late BuildContext context;

  HttpService http = HttpService();

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  bool _isEditing = false;
  bool get isEditing => _isEditing;
  void setChangeIsEditingValue() {
    _isEditing = !isEditing;
    notifyListeners();
  }

  List<TermConditionCategoryData> _termConditionCategoryList = [];
  List<TermConditionCategoryData> get termConditionCategoryList => _termConditionCategoryList;

  // List<Map> tempTermConditionList = [
  //   {
  //     'title': 'Kategori Kesehatan',
  //     'list_tnc': [
  //       'Klaim harus mencakup biaya pengobatan yang sah dan terkait langsung dengan kesehatan pribadi karyawan.',
  //       'Dokumen asli seperti faktur rumah sakit, resep dokter, dan kwitansi pembayaran harus disertakan dengan klaim.',
  //       'Pengajuan klaim harus diajukan dalam waktu 30 hari setelah pembayaran dilakukan.',
  //     ]
  //   },
  //   {
  //     'title': 'Kategori Transportasi',
  //     'list_tnc': [
  //       'Biaya transportasi yang dapat diklaim termasuk perjalanan dinas, tiket pesawat, transportasi darat, dan sewa kendaraan.',
  //       'Klaim harus mencakup rincian perjalanan seperti tujuan, tanggal perjalanan, dan jumlah biaya yang dikeluarkan.',
  //       'Dokumen pendukung seperti tiket, kwitansi, atau bukti pembayaran harus dilampirkan bersama dengan formulir klaim.',
  //     ]
  //   }
  // ];

  void addCondition({required int categoryIndex, required String condition}) {
    _termConditionCategoryList[categoryIndex].list_tnc.add(TermConditionData(tnc: condition));

    notifyListeners();
  }

  void deleteCondition({required int categoryIndex, required int conditionIndex}) {
    _termConditionCategoryList[categoryIndex].list_tnc.removeAt(conditionIndex);
    // log('${termConditionList[categoryIndex].listTnc}');
    notifyListeners();
  }

  void updateCondition(
      {required int categoryIndex, required int conditionIndex, required String newCondition}) {
    _termConditionCategoryList[categoryIndex].list_tnc[conditionIndex].tnc = newCondition;
    // termConditionList[categoryIndex].listTnc[conditionIndex] = newCondition;
    // notifyListeners();
  }

  Future cancelEdit() {
    _isEditing = false;
    notifyListeners();

    return Future.value(true);
  }

  Future getTnc() async {
    startLoading();
    notifyListeners();

    String endpoint = 'tnc/get-tnc';

    await http.post(endpoint: endpoint).then((res) {
      TermConditionResponse response = TermConditionResponse.fromJson(res);
      if (response.success) {
        _termConditionCategoryList = response.data;

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

  Future postEditTnc() async {
    startLoading();
    _isEditing = false;
    notifyListeners();

    String endpoint = 'tnc/edit-tnc';
    Map body = {'list_category_tnc': termConditionCategoryList.map((e) => e.toJson()).toList()};

    await http.post(endpoint: endpoint, body: body).then((res) {
      TermConditionResponse response = TermConditionResponse.fromJson(res);
      if (response.success) {
        Helper(context: context).showToast(message: response.msg, isSuccess: true);
        getTnc();
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
}
