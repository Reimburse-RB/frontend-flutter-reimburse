import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/widgets/employee/card_submission_employee.dart';

class ListSubmission extends StatelessWidget {
  const ListSubmission({
    super.key,
    required this.listReimbursement,
  });

  final List<GetUserReimburseData> listReimbursement;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listReimbursement.length,
      itemBuilder: (context, index) {
        GetUserReimburseData item = listReimbursement[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: CardSubmissionEmployee(reimburseData: item),
        );
      },
    );
  }
}
