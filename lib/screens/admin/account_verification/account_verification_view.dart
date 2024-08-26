import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/admin/account_verification_response.dart';
import 'package:reimburse_rb/screens/admin/account_verification/account_verification_view_model.dart';
import 'package:reimburse_rb/widgets/admin/card_account_verification.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/empty_state_general.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';

class AccountVerificationListScreen extends StatelessWidget {
  const AccountVerificationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountVerificationViewModel>(
      create: (context) => AccountVerificationViewModel(context: context),
      child: const AccountVerificationListView(),
    );
  }
}

class AccountVerificationListView extends StatelessWidget {
  const AccountVerificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AccountVerificationViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Verifikasi Akun',
      ),
      body: LoadingFallback(
        isLoading: viewModel.isLoading,
        child: viewModel.listAccountVerification.isEmpty
            ? const Column(
                children: [
                  Spacer(),
                  EmptyStateGeneral(),
                  Spacer(),
                ],
              )
            : ListView(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.listAccountVerification.length,
                    itemBuilder: (context, index) {
                      AccountVerificationData item = viewModel.listAccountVerification[index];
                      return CardAccountVerification(
                        accountVerificationData: item,
                        viewModel: viewModel,
                      );
                    },
                  )
                ],
              ),
      ),
    );
  }
}
