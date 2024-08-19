import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';

class CardSubmissionEmployee extends StatelessWidget {
  const CardSubmissionEmployee({
    super.key,
    required this.reimburseData,
  });

  final ItemUserReimburseData reimburseData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (reimburseData.id != null) {
          context
              .read<NavigationProvider>()
              .navigateToDetailReimbursement(context: context, id: reimburseData.id!);
        }
      },
      child: Card(
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
                  Image.asset(
                    Helper(context: context).getStatusAsset(statusId: reimburseData.statusId),
                    width: 48,
                    height: 48,
                  ),
                  const SizedBox(width: 12.0),
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
                        const SizedBox(height: 8.0),
                        Text(
                          reimburseData.typeReimburse ?? '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: Constant.semiBoldText,
                          ),
                        ),
                        const SizedBox(height: 4.0),
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
