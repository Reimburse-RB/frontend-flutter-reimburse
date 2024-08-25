import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_home/submission_home_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/empty_state_general.dart';
import 'package:reimburse_rb/widgets/common/floating_action_button_general.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';
import 'package:reimburse_rb/widgets/employee/list_submission.dart';

class SubmissionHomeScreen extends StatelessWidget {
  const SubmissionHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubmissionHomeViewModel>(
      create: (_) => SubmissionHomeViewModel(context: context),
      child: const SubmissionHomeView(),
    );
  }
}

class SubmissionHomeView extends StatefulWidget {
  const SubmissionHomeView({super.key});

  @override
  State<SubmissionHomeView> createState() => _SubmissionHomeViewState();
}

class _SubmissionHomeViewState extends State<SubmissionHomeView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final viewModel = context.read<SubmissionHomeViewModel>();

    viewModel.initTabController(this, viewModel.listStatusTab.length);

    super.initState();
  }

  @override
  void dispose() {
    final viewModel = context.read<SubmissionHomeViewModel>();

    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SubmissionHomeViewModel>();
    final userProvider = context.read<UserProvider>();
    return Scaffold(
      appBar: AppBarGeneral(
        context: context,
        title: 'Pengajuan Reimbursement',
        isHasCustomLeading: false,
        height: 126,
        bottomWidget: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          isScrollable: true,
          labelStyle: GoogleFonts.poppins(
            fontWeight: Constant.extraBoldText,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: Constant.mediumWeightText,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade200,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          controller: viewModel.tabController,
          tabs: [
            for (int i = 0; i < viewModel.listStatusTab.length; i++)
              Tab(
                text: viewModel.listStatusTab[i],
              ),
          ],
        ),
      ),
      floatingActionButton: (!userProvider.isAdmin)
          ? FloatingActionButtonGeneral(
              onPressed: () {
                Helper(context: context).showModalReimbursement(
                  context: context,
                  title: viewModel.modalTitle,
                  listOptions: viewModel.modalOptionList,
                );
              },
            )
          : null,
      body: LoadingFallback(
        isLoading: viewModel.isLoading,
        child: TabBarView(
          controller: viewModel.tabController,
          children: viewModel.listStatusTab.map((tab) {
            return (viewModel.listReimbursement.isEmpty)
                ? const Column(
                    children: [
                      Spacer(),
                      EmptyStateGeneral(),
                      Spacer(),
                    ],
                  )
                : ListView(
                    padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
                    children: [
                      ListSubmission(
                        listReimbursement: viewModel.listReimbursement,
                      ),
                    ],
                  );
          }).toList(),
        ),
      ),
      // const Column(
      //   children: [
      //     Spacer(),
      //     EmptyStateGeneral(),
      //     Spacer(),
      //   ],
      // )
    );
  }
}
