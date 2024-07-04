import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_home/submission_home_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/employee/list_submission.dart';

class SubmissionHomeScreen extends StatelessWidget {
  const SubmissionHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubmissionHomeViewModel>(
      create: (_) => SubmissionHomeViewModel(),
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
  TabController? tabController;

  @override
  void initState() {
    final viewModel = Provider.of<SubmissionHomeViewModel>(context, listen: false);

    tabController = TabController(vsync: this, length: viewModel.listStatusTab.length);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SubmissionHomeViewModel>();
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
          controller: tabController,
          tabs: [
            for (int i = 0; i < viewModel.listStatusTab.length; i++)
              Tab(
                text: viewModel.listStatusTab[i],
              ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 64.0,
        width: 64.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.add_rounded,
              size: 32,
            ),
            backgroundColor: Constant.green,
            elevation: 8.0,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24, bottom: 32),
        children: [
          Container(
            child: const ListSubmission(),
          ),
        ],
      ),
    );
  }
}
