import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';

class CardSubmission extends StatelessWidget {
  const CardSubmission({
    super.key,
    this.isShowIcon = true,
    required this.reimburseData,
    required this.onReturn,
  });

  final bool isShowIcon;
  final ItemUserReimburseData reimburseData;
  final Function(dynamic) onReturn;

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    bool isAdmin = userProvider.isAdmin;
    return InkWell(
      onTap: () {
        if (reimburseData.id != null) {
          context.read<NavigationProvider>().navigateToDetailReimbursement(
                context: context,
                id: reimburseData.id!,
                onReturn: onReturn,
              );
        }
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Text(
                  reimburseData.createdDate ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: Constant.lightWeightText,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isShowIcon) ...[
                    Image.asset(
                      Helper(context: context).getStatusAsset(statusId: reimburseData.statusId),
                      width: 48,
                      height: 48,
                    ),
                    const SizedBox(width: 12.0),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reimburseData.status ?? '',
                          style: TextStyle(
                            color: Helper(context: context)
                                .getStatusColor(statusId: reimburseData.statusId),
                            fontSize: 12.0,
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        if (isAdmin) ...[
                          Text(
                            reimburseData.name ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: Constant.boldText,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            reimburseData.nik ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14.0,
                              fontWeight: Constant.lightWeightText,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                        ],
                        Text(
                          reimburseData.typeReimburse ?? '',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: isAdmin ? Constant.mediumWeightText : Constant.semiBoldText,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          'Total : Rp ${Helper(context: context).formatCurrency(amount: reimburseData.totalPrice ?? 0)}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: Constant.semiBoldText,
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
      ),
    );
  }
}
