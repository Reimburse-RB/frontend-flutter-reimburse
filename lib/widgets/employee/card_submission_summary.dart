import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/employee_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardSubmissionSummary extends StatefulWidget {
  const CardSubmissionSummary({
    super.key,
  });

  @override
  State<CardSubmissionSummary> createState() => _CardSubmissionSummaryState();
}

class _CardSubmissionSummaryState extends State<CardSubmissionSummary> {
  Widget summaryDetail({
    required String iconAsset,
    Icon? iconAlternative,
    required String detailTitle,
    required String detailValue,
  }) {
    return Row(
      children: [
        if (iconAlternative == null)
          Image.asset(
            iconAsset,
            width: 24,
            height: 24,
          ),
        if (iconAlternative != null) iconAlternative,
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  detailTitle,
                  style: const TextStyle(
                    fontWeight: Constant.mediumWeightText,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                detailValue,
                style: const TextStyle(
                  fontWeight: Constant.mediumWeightText,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EmployeeProvider>();
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 20,
        ),
        child: Column(
          children: [
            // summaryDetail(
            //   iconAsset: 'assets/status/icon-status-waiting.png',
            //   detailTitle: 'Reimburse Menunggu Diproses',
            //   detailValue: '1',
            // ),
            // const SizedBox(height: 8),

            summaryDetail(
              iconAsset: 'assets/status/icon-status-process.png',
              detailTitle: 'Reimburse Diproses',
              detailValue: viewModel.employeeSummaryData?.onproceed.toString() ?? '0',
            ),
            const SizedBox(height: 8),
            summaryDetail(
              iconAsset: 'assets/status/icon-status-succeed.png',
              detailTitle: 'Reimburse Disetujui',
              detailValue: viewModel.employeeSummaryData?.accepted.toString() ?? '0',
            ),
            const SizedBox(height: 8),
            summaryDetail(
              iconAsset: 'assets/status/icon-status-failed.png',
              detailTitle: 'Reimburse Ditolak',
              detailValue: viewModel.employeeSummaryData?.rejected.toString() ?? '0',
            ),
            const SizedBox(height: 8),
            summaryDetail(
              iconAsset: '',
              iconAlternative: const Icon(
                IconlyBold.graph,
                size: 24,
                color: Constant.limitColor,
              ),
              detailTitle: 'Total Tahun Ini',
              detailValue: viewModel.formatCurrency(
                  viewModel.employeeSummaryData?.total_reimburse_this_year.toDouble() ?? 0),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.only(left: 32),
              child: LinearProgressIndicator(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Constant.limitColor,
                value: 0.15,
                backgroundColor: Colors.grey.shade300,
              ),
            )
          ],
        ),
      ),
    );
  }
}
