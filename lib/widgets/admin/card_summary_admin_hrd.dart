import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/widgets/common/detail_summary.dart';

class CardSummaryAdminHrd extends StatefulWidget {
  const CardSummaryAdminHrd({
    super.key,
  });

  @override
  State<CardSummaryAdminHrd> createState() => _CardSummaryAdminHrdState();
}

class _CardSummaryAdminHrdState extends State<CardSummaryAdminHrd> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<UserProvider>();
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
            DetailSummary(
              iconAsset: 'assets/status/icon-status-process.png',
              detailTitle: 'Total Reimburse Diproses',
              detailValue: viewModel.adminSummaryData?.totalDiproses.toString() ?? '0',
            ),
            const SizedBox(height: 8),
            DetailSummary(
              iconAsset: 'assets/other/icon-status-health.png',
              detailTitle: 'Reimburse Kesehatan Diproses',
              detailValue: viewModel.adminSummaryData?.totalKesehatanDiproses.toString() ?? '0',
            ),
            const SizedBox(height: 8),
            DetailSummary(
              iconAsset: 'assets/other/icon-status-transportation.png',
              detailTitle: 'Reimburse Transportasi Diproses',
              detailValue: viewModel.adminSummaryData?.totalTrasnportDiproses.toString() ?? '0',
            ),
          ],
        ),
      ),
    );
  }
}
