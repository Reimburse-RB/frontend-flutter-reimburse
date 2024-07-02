import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardRecapitulation extends StatelessWidget {
  const CardRecapitulation({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Disetujui',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: Constant.lightWeightText,
                    color: Constant.acceptedStatusTextColor,
                  ),
                ),
                Text(
                  '21 Februari 2024',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: Constant.lightWeightText,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Reimbursement Kesehatan',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: Constant.semiBoldText,
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                Text(
                  'Total :',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: Constant.semiBoldText,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'Rp 250.000,00',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: Constant.semiBoldText,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
