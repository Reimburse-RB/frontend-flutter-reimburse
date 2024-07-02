import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/screens/employee/profile/profile_view_model.dart';
import 'package:reimburse_rb/utility/authentication.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => ProfileViewModel(context: context),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final viewModel = context.watch<ProfileViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Profil',
        isHasCustomLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              viewModel.isAdmin
                  ? const FaIcon(
                      FontAwesomeIcons.userShield,
                      color: Constant.greenDark,
                      size: 20,
                    )
                  : const Icon(
                      IconlyBold.user_2,
                      color: Constant.greenDark,
                      size: 24,
                    ),
              const SizedBox(width: 8),
              Text(
                viewModel.profile.roleText,
                style: const TextStyle(
                    fontSize: 16, fontWeight: Constant.boldText, color: Constant.greenDark),
              ),
            ],
          ),
          const SizedBox(height: 16),
          CachedNetworkImage(
            width: width / 2,
            height: width / 2,
            imageUrl: viewModel.profile.imgUrl,
            imageBuilder: (context, imageProvider) {
              return Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(width: 2, color: Constant.greenDark),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image: imageProvider),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            viewModel.profile.name,
            style: Constant.secondTitleStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            viewModel.profile.email,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ButtonGeneral(
            onTap: () {
              viewModel.navigateToProfileDetail();
            },
            text: 'Lihat Informasi Pribadi',
          ),
          const SizedBox(height: 96),
          ButtonGeneral(
            onTap: () {
              Authentication.signOut(context: context);
            },
            isWhiteButton: true,
            prefixIcon: const Icon(
              IconlyLight.logout,
              color: Constant.green,
            ),
            text: 'Logout',
          ),
        ],
      ),
    );
  }
}
