import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/menu_data.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/admin/card_summary_admin_hrd.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/empty_state_general.dart';
import 'package:reimburse_rb/widgets/common/list_horizontal_menu.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';
import 'package:reimburse_rb/widgets/employee/card_submission_summary.dart';
import 'package:reimburse_rb/widgets/employee/list_submission.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(
        context: context,
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Widget buildSubmissionSummary(BuildContext context) {
    bool isAdmin = context.read<UserProvider>().isAdmin;
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isAdmin ? 'Permintaan Saat Ini' : 'Ringkasan Pengajuan',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: Constant.semiBoldText,
            ),
          ),
          const SizedBox(height: 12),
          isAdmin ? const CardSummaryAdminHrd() : const CardSubmissionSummary(),
        ],
      ),
    );
  }

  Widget buildHorizontalMenu(BuildContext context, HomeViewModel viewModel) {
    bool isAdmin = context.read<UserProvider>().isAdmin;

    int listCategoryMenuLength = isAdmin
        ? viewModel.listMenuCategoryAdmin.length
        : viewModel.listMenuCategoryEmployee.length;
    List<MenuCategoryData> listCategoryMenu =
        isAdmin ? viewModel.listMenuCategoryAdmin : viewModel.listMenuCategoryEmployee;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: listCategoryMenuLength,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        MenuCategoryData menuCategoryData = listCategoryMenu[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListHorizontalMenu(
              menuCategory: menuCategoryData,
              padding: const EdgeInsets.symmetric(horizontal: 24),
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }

  Widget buildActiveSubmissionList(HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pengajuan Aktif',
            style: TextStyle(
              fontSize: 16,
              fontWeight: Constant.semiBoldText,
            ),
          ),
          const SizedBox(height: 12),
          (viewModel.listReimbursementActive.isNotEmpty)
              ? ListSubmission(
                  listReimbursement: viewModel.listReimbursementActive,
                  onReturn: (value) {
                    viewModel.getData();
                  },
                )
              : const EmptyStateGeneral(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final userProvider = context.read<UserProvider>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarGeneral(
          context: context,
          isHasCustomLeading: false,
          customImage: 'assets/apps_logo/logo-horizontal-white-reimburserb.png',
        ),
        body: LoadingFallback(
          isLoading: viewModel.isLoading,
          child: ListView(
            children: [
              const SizedBox(height: 24),
              buildSubmissionSummary(context),
              buildHorizontalMenu(context, viewModel),
              if (!userProvider.isAdmin) buildActiveSubmissionList(viewModel),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
