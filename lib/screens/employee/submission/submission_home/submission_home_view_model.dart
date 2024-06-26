import 'package:flutter/material.dart';

class SubmissionHomeViewModel extends ChangeNotifier {
  List listStatusTab = [
    'Semua',
    'Menunggu Diproses',
    'Sedang Diproses',
    'Selesai',
  ];

  SubmissionHomeViewModel() {}

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
}
