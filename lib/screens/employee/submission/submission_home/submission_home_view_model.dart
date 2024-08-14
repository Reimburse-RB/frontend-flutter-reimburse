import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/modal_data.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';

class SubmissionHomeViewModel extends ChangeNotifier {
  SubmissionHomeViewModel({
    required this.context,
  }) {
    final userProvider = context.read<UserProvider>();
    List listReimbursementCategory = userProvider.listReimbursementCategory;
    for (ReimbursementCategoryData reimbursementCategory in listReimbursementCategory) {
      modalOptionList.add(
        ModalRegularData(
          text: 'Reimburse ${reimbursementCategory.categoryReimbursementText}',
          onTap: () {
            context.read<NavigationProvider>().navigateToFormReimbursement(
                  context: context,
                  reimbursementCategory: reimbursementCategory,
                );
          },
        ),
      );
    }
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

  onTapTab() {}
}
