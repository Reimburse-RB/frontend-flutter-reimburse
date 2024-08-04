import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ph.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/screens/employee/profile/profile_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/bottom_appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/empty_state_general.dart';
import 'package:reimburse_rb/widgets/common/floating_action_button_general.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';
import 'package:reimburse_rb/widgets/common/image_circle_general.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';
import 'package:reimburse_rb/widgets/employee/card_family_member.dart';

class ProfileDetailSceen extends StatelessWidget {
  const ProfileDetailSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel(context: context, isProfileDetail: true),
      child: const ProfileDetailView(),
    );
  }
}

class ProfileDetailView extends StatefulWidget {
  const ProfileDetailView({super.key});

  @override
  State<ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  Widget buildFamilyForm({required ProfileViewModel viewModel}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Anggota Keluarga',
            style: Constant.secondTitleStyle,
          ),
          const SizedBox(height: 16),
          if (viewModel.profile?.family_member_data.isEmpty ?? false) const EmptyStateGeneral(),
          ListView.builder(
            itemCount: viewModel.profile?.family_member_data.length ?? 0,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              FamilyMemberData? familyMemberItemData = viewModel.profile?.family_member_data[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: CardFamilyMember(
                  viewModel: viewModel,
                  memberIndex: index,
                  status: viewModel.listFamilyStatusOptionMap.firstWhere(
                      (element) => element['id'] == familyMemberItemData?.family_status_id),
                  listStatusOption: viewModel.listFamilyStatusOptionMap,
                  name: familyMemberItemData?.name ?? '',
                  isActiveDeleteButton: !(familyMemberItemData?.family_status_id == 1),
                ),
              );
            },
          ),
          if (viewModel.isEditing)
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: ButtonGeneral(
                onTap: () {
                  viewModel.addFamilyMember();
                },
                text: 'Tambah Anggota Keluarga',
                prefixIcon: const Icon(
                  Icons.add_rounded,
                  color: Constant.green,
                ),
                isWhiteButton: true,
              ),
            )
        ],
      ),
    );
  }

  Widget buildFormDivider() {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      height: 20,
      color: Colors.grey.shade200,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final viewModel = context.watch<ProfileViewModel>();

    return WillPopScope(
      onWillPop: () async {
        if (viewModel.isEditing) {
          await Helper(context: context).alertClose(
            title: 'Konfirmasi',
            message:
                'Apakah Anda yakin akan keluar dari halaman ini? Perubahan tidak akan disimpan.',
            context: context,
            firstButtonOnTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            secondButtonOnTap: () {
              Navigator.pop(context);
            },
          );
          return false; // return false if alertClose is shown
        } else {
          Navigator.pop(context);
          return true; // return true if not editing
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarGeneral(
          context: context,
          title: 'Informasi Pribadi ${viewModel.profile?.role_text}',
        ),
        bottomNavigationBar: (viewModel.isEditing)
            ? BottomAppBarGeneral(
                child: Row(
                  children: [
                    Flexible(
                      child: ButtonGeneral(
                        onTap: () {
                          viewModel.cancelEdit();
                        },
                        text: 'Batalkan',
                        isWhiteButton: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: ButtonGeneral(
                        onTap: () {
                          viewModel.saveEdit();
                        },
                        text: 'Simpan',
                      ),
                    ),
                  ],
                ),
              )
            : null,
        floatingActionButton: (!viewModel.isEditing)
            ? FloatingActionButtonGeneral(
                onPressed: () {
                  viewModel.startEdit();
                },
                icon: const Icon(
                  Icons.edit_rounded,
                  size: 32,
                ),
              )
            : null,
        body: LoadingFallback(
          isLoading: viewModel.isLoading,
          child: ListView(
            children: [
              const SizedBox(height: 24),
              ImageCircleGeneral(
                size: width / 2,
                imageUrl: viewModel.profile?.img_url,
              ),
              const SizedBox(height: 24),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormFieldText(
                        controllerName: viewModel.nameController,
                        isEnabled: viewModel.isEditing,
                        placeholder: "Nama Lengkap",
                        hintText: "Masukkan nama lengkap",
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FormFieldText(
                        controllerName: viewModel.nikController,
                        isEnabled: viewModel.isEditing,
                        placeholder: "Nomor Induk Karyawan (NIK)",
                        hintText: "Masukkan nomor induk karyawan",
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FormFieldText(
                        controllerName: viewModel.emailController,
                        isEnabled: viewModel.isEditing,
                        placeholder: "Email",
                        hintText: "Masukkan email",
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              if (!viewModel.isAdmin) buildFormDivider(),
              if (!viewModel.isAdmin) const SizedBox(height: 24),
              if (!viewModel.isAdmin) buildFamilyForm(viewModel: viewModel),
              if (!viewModel.isAdmin) const SizedBox(height: 32),
              buildFormDivider(),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ButtonGeneral(
                  onTap: () {
                    viewModel.navigateToForgotPasswordScreen();
                  },
                  text: 'Ubah Password',
                  prefixIcon: const Iconify(
                    Ph.password_bold,
                    color: Constant.green,
                  ),
                  isWhiteButton: true,
                ),
              ),
              const SizedBox(height: 96),
            ],
          ),
        ),
      ),
    );
  }
}
