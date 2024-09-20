import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/notification_response.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({super.key, required this.notificationData});

  final ItemNotificationData notificationData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    (notificationData.categoryReimbursement ?? '') + 'akdbasbkjdsad',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: Constant.lightWeightText,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  notificationData.dateReimburse ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: Constant.lightWeightText,
                    color: Constant.darkGrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              notificationData.title ?? '',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: Constant.semiBoldText,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              notificationData.body ?? '',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: Constant.lightWeightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
