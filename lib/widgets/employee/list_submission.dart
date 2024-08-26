import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/widgets/common/card_submission.dart';

class ListSubmission extends StatelessWidget {
  const ListSubmission({
    super.key,
    required this.listReimbursement,
    required this.onReturn,
  });

  final List<ItemUserReimburseData> listReimbursement;
  final Function(dynamic) onReturn;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listReimbursement.length,
      itemBuilder: (context, index) {
        ItemUserReimburseData item = listReimbursement[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: CardSubmission(
            reimburseData: item,
            onReturn: onReturn,
          ),
        );
      },
    );
  }
}
