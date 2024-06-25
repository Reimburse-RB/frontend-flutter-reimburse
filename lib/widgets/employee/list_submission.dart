import 'package:flutter/material.dart';
import 'package:reimburse_rb/widgets/employee/card_submission.dart';

class ListSubmission extends StatefulWidget {
  const ListSubmission({super.key});

  @override
  State<ListSubmission> createState() => _ListSubmissionState();
}

class _ListSubmissionState extends State<ListSubmission> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          child: const CardSubmissionEmployee(),
        );
      },
    );
  }
}
