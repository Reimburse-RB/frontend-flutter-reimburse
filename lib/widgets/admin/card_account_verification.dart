import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/admin/account_verification_response.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/screens/admin/account_verification/account_verification_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/image_circle_general.dart';

class CardAccountVerification extends StatelessWidget {
  const CardAccountVerification({
    super.key,
    required this.accountVerificationData,
    required this.viewModel,
  });

  final AccountVerificationData accountVerificationData;
  final AccountVerificationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (accountVerificationData.id != null) {
          final navigationProvider = context.read<NavigationProvider>();
          navigationProvider.navigateToDetailAccountVerification(
            context: context,
            id: accountVerificationData.id!,
            onReturn: (value) {
              viewModel.getData();
            },
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
            horizontal: 20,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageCircleGeneral(
                size: 60,
                imageUrl: accountVerificationData.img_url,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      accountVerificationData.name ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: Constant.boldText,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      accountVerificationData.nik ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: Constant.lightWeightText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
