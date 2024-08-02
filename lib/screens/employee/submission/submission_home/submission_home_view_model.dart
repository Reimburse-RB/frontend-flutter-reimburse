import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/modal_data.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';

class SubmissionHomeViewModel extends ChangeNotifier {
  SubmissionHomeViewModel({
    required this.context,
  }) {
    modalOptionList = [
      ModalRegularData(
        text: 'Reimburse Kesehatan',
        onTap: () {
          context.read<NavigationProvider>().navigateToFormReimbursement(context: context);
        },
      ),
      ModalRegularData(
        text: 'Reimburse Transportasi',
        onTap: () {
          context.read<NavigationProvider>().navigateToFormReimbursement(context: context);
        },
      ),
    ];
  }

  BuildContext context;

  String modalTitle = 'Jenis Pengajuan';
  List<ModalRegularData> modalOptionList = [];

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
}
