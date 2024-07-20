import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reimburse_rb/screens/common/detail_reimbursement/detail_reimbursement_view.dart';

class SubmissionHomeViewModel extends ChangeNotifier {
  SubmissionHomeViewModel() {}

  List listStatusTab = [
    'Semua',
    'Menunggu Diproses',
    'Sedang Diproses',
    'Selesai',
  ];

  List listAllSubmission = [
    {
      'date': '21 Februari 2024',
      'category_id': 'Reimbursement Kesehatan',
      'category_text': 'Reimbursement Transportasi',
      'status_id': '1',
      'status_text': 'Menunggu Diproses',
      'name': 'Yudha Haryoputranto',
      'nik': '2010511068',
      'total': 'Rp. 250.000,00',
    }
  ];

  onTapTab() {}

  void navigateToDetailReimbursement({required BuildContext context}) {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const DetailReimbursementScreen(),
    ));
  }
}
