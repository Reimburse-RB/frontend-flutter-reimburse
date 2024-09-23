import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/notification_response.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardNotification extends StatelessWidget {
  const CardNotification({super.key, required this.notificationData});

  final ItemNotificationData notificationData;

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.read<NavigationProvider>();

    return InkWell(
      customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: (notificationData.categoryNotification == Constant.categoryNotificationReimburse)
          ? () {
              int? reimburseId = notificationData.reimburseId;
              if (reimburseId != null) {
                navigationProvider.navigateToDetailReimbursement(
                  context: context,
                  id: notificationData.reimburseId!,
                  onReturn: (value) {},
                );
              }
            }
          : (notificationData.categoryNotification == Constant.categoryNotificationAccountVerif)
              ? () {
                  int? userId = notificationData.userId;
                  if (userId != null)
                    navigationProvider.navigateToDetailAccountVerification(
                      context: context,
                      id: userId,
                      onReturn: (value) {},
                    );
                }
              : null,
      child: Card(
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
                      (notificationData.categoryReimbursement ?? ''),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: Constant.lightWeightText,
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    notificationData.date ?? '',
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
      ),
    );
  }
}
