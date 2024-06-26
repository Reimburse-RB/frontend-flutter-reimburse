import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Reimbursement Kesehatan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: Constant.lightWeightText,
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
              'Pengajuan Berhasil',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: Constant.semiBoldText,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'Pengajuan reimburse kesehatan Anda berhasil, silakan cek saldo rekening Anda',
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: Constant.lightWeightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
