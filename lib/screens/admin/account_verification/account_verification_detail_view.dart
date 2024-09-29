import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/screens/admin/account_verification/account_verification_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/card_detail_family_member.dart';
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
              onTap: viewModel.detailAccount?.img_url != null
                  ? () {
                      Helper(context: context).viewPhoto(
                        source: viewModel.detailAccount?.img_url,
                      );
                    }
                  : null,
            ),
            DetailText(
              title:
                  'Status Akun ${(viewModel.detailAccount?.is_account_verified ?? false) ? ' ✔' : ''}',
              valueBackgroundColor: (viewModel.detailAccount?.is_account_verified ?? false)
                  ? Constant.greenMedium
                  : Constant.grey,
              valueBackgroundEnabled: true,
              textValue: (viewModel.detailAccount?.is_account_verified ?? false)
                  ? 'Akun terverifikasi '
                  : 'Akun belum terverifikasi',
              valueColor: Colors.white,
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
            const SizedBox(height: 20),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              shrinkWrap: true,
              itemCount: viewModel.detailAccount?.family_member_data.length ?? 0,
              itemBuilder: (context, index) {
                FamilyMemberData? item = viewModel.detailAccount?.family_member_data[index];
                if (item != null) {
                  return CardDetailFamilyMember(itemFamilyMemberData: item, index: index);
                } else {
                  return Container();
                }
              },
            ),
            const SizedBox(height: 32),
            if (viewModel.detailAccount != null &&
                !(viewModel.detailAccount?.is_account_verified ?? false))
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: ButtonGeneral(
                    onTap: () {
                      viewModel.postVerification();
                    },
                    text: 'Terima'),
              ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
