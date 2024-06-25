import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardSubmissionEmployee extends StatelessWidget {
  const CardSubmissionEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: Text(
                '21 Februari 2024',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: Constant.lightWeightText,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/status/icon-status-process.png',
                  width: 48,
                  height: 48,
                ),
                const SizedBox(width: 12.0),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reimbursement Transportasi',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: Constant.semiBoldText,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'Menunggu persetujuan Admin',
                        style: TextStyle(
                          color: Constant.processStatusTextColor,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
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
