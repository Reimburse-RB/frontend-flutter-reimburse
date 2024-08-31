import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/detail_text.dart';

class CardDetailCost extends StatelessWidget {
  final ItemDetailReimburseData itemDetailReimburseData;
  final int? categoryReimbursementId;
  final int index;

  const CardDetailCost({
    Key? key,
    required this.itemDetailReimburseData,
    required this.categoryReimbursementId,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: const BoxDecoration(
              color: Constant.greenDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text(
              'Rincian ${index + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailText(
                  title:
                      'Rincian ${categoryReimbursementId == Constant.healthCategoryReimbursementId ? 'Perawatan' : categoryReimbursementId == Constant.transportCategoryReimbursementId ? 'Perjalanan' : ''}',
                  textValue: itemDetailReimburseData.detail_title_text ?? '',
                ),
                if (categoryReimbursementId == Constant.healthCategoryReimbursementId) ...[
                  const SizedBox(height: 16),
                  DetailText(
                    title: 'Diperuntukkan untuk...',
                    textValue: itemDetailReimburseData.detail_family_name ?? '',
                  ),
                ],
                const SizedBox(height: 16),
                DetailText(
                  title: 'Tanggal Kuitansi',
                  textValue: itemDetailReimburseData.detail_date ?? '',
                ),
                const SizedBox(height: 16),
                DetailText(
                  title: 'Biaya',
                  costValue: itemDetailReimburseData.detail_cost,
                ),
                const SizedBox(height: 16),
                DetailText(
                  title: 'Keterangan',
                  textValue: itemDetailReimburseData.detail_desc ?? '',
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
