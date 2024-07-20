import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/screens/common/detail_reimbursement/detail_reimbursement_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/list_horizontal_detail_receipt_image.dart';

class DetailReimbursementScreen extends StatelessWidget {
  const DetailReimbursementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailReimbursementViewModel>(
      create: (_) => DetailReimbursementViewModel(),
      child: const DetailReimbursementView(),
    );
  }
}

class DetailReimbursementView extends StatelessWidget {
  const DetailReimbursementView({super.key});

  Widget buildDetailText({
    required String title,
    String? textValue,
    double? costValue,
    Color valueColor = Colors.black,
    EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 24),
  }) {
    final formatter =
        NumberFormat.currency(locale: 'id_ID', decimalDigits: 2, symbol: 'Rp ');
    return Container(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Constant.secondTitleStyle,
          ),
          const SizedBox(height: 8),
          if (costValue != null)
            Text(
              formatter.format(costValue),
              style: TextStyle(color: valueColor),
            ),
          if (textValue != null)
            Text(
              textValue,
              style: TextStyle(color: valueColor),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Detail Reimbursement',
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          buildDetailText(
            title: 'Status',
            textValue: 'Menunggu Diproses',
            valueColor: Constant.waitingStatusColor,
          ),
          const SizedBox(height: 20),
          buildDetailText(
            title: 'Nama Karyawan',
            textValue: 'Yudha Haryoputranto',
          ),
          const SizedBox(height: 20),
          buildDetailText(
            title: 'Diagnosis',
            textValue: 'Flu Batuk',
          ),
          const SizedBox(height: 20),
          buildDetailText(
            title: 'Total Biaya',
            costValue: 250000,
          ),
          const SizedBox(height: 20),
          const ListHorizontalDetailReceiptImage(
            title: 'Lampiran',
            listImageUrl: [
              'https://www.pdffiller.com/preview/470/590/470590793/large.png',
              'https://imgv2-1-f.scribdassets.com/img/document/556166473/original/d5434b43c5/1718521196?v=1',
              'https://imgv2-1-f.scribdassets.com/img/document/555063486/original/87a635ab89/1719397768?v=1',
            ],
          )
        ],
      ),
    );
  }
}
