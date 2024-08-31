import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/screens/admin/account_verification/account_verification_view_model.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/detail_text.dart';
import 'package:reimburse_rb/widgets/common/image_circle_general.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';

class DetailAccountVerificationScreen extends StatelessWidget {
  const DetailAccountVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccountVerificationViewModel>(
      create: (context) => AccountVerificationViewModel(context: context, isDetailScreen: true),
      child: const DetailAccountVerificationView(),
    );
  }
}

class DetailAccountVerificationView extends StatelessWidget {
  const DetailAccountVerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AccountVerificationViewModel>();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Detail Verifikasi Akun',
      ),
      body: LoadingFallback(
        isLoading: viewModel.isLoading,
        child: ListView(
          children: [
            const SizedBox(height: 24),
            ImageCircleGeneral(
              size: width / 2,
              imageUrl: viewModel.detailAccount?.img_url,
            ),
            DetailText(
              title: 'Nama Karyawan',
              textValue: viewModel.detailAccount?.name ?? '',
            ),
            DetailText(
              title: 'Email',
              textValue: viewModel.detailAccount?.email ?? '',
            ),
            DetailText(
              title: 'Nomor Induk Karyawan',
              textValue: viewModel.detailAccount?.nik ?? '',
            ),
            DetailText(
              title: 'Role',
              textValue: viewModel.detailAccount?.role_text ?? '',
            ),
            const SizedBox(height: 32),
            if (viewModel.detailAccount != null)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: ButtonGeneral(
                    onTap: () {
                      viewModel.postVerification();
                    },
                    text: 'Terima'),
              ),
          ],
        ),
      ),
    );
  }
}
