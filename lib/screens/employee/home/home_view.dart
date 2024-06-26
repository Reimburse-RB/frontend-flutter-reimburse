import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/menu_data.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/list_horizontal_menu.dart';
import 'package:reimburse_rb/widgets/employee/card_submission_summary.dart';
import 'package:reimburse_rb/widgets/employee/list_submission.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.moveToAnotherTab});

  final Function(int) moveToAnotherTab;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) => HomeViewModel(moveToAnotherTab: moveToAnotherTab),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  Widget buildSubmissionSummary() {
    return Container(
      margin: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan Pengajuan',
            style: TextStyle(
              fontSize: 16,
              fontWeight: Constant.semiBoldText,
            ),
          ),
          SizedBox(height: 12),
          CardSubmissionSummary(),
        ],
      ),
    );
  }

  Widget buildHorizontalMenu(HomeViewModel viewModel) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.listMenuCategory.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        MenuCategoryData menuCategoryData = viewModel.listMenuCategory[index];
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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pengajuan Aktif',
            style: TextStyle(
              fontSize: 16,
              fontWeight: Constant.semiBoldText,
            ),
          ),
          SizedBox(height: 12),
          ListSubmission(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarGeneral(
          context: context,
          isHasCustomLeading: false,
          customImage: 'assets/apps_logo/logo-horizontal-white-reimburserb.png',
        ),
        body: ListView(
          children: [
            const SizedBox(height: 24),
            buildSubmissionSummary(),
            buildHorizontalMenu(viewModel),
            buildActiveSubmissionList(viewModel),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
