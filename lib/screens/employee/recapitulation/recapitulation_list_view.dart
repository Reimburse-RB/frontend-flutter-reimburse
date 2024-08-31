import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/recapitulation/recapitulation_view_model.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/card_submission.dart';
import 'package:reimburse_rb/widgets/common/floating_action_button_general.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';

class RecapitulationListScreen extends StatelessWidget {
  const RecapitulationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecapitulationViewModel>(
      create: (context) => RecapitulationViewModel(context: context),
      child: const RecapitulationListView(),
    );
  }
}

class RecapitulationListView extends StatelessWidget {
  const RecapitulationListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecapitulationViewModel>();
    final userProvider = context.read<UserProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: userProvider.selectedRecapitulationMonth ?? '',
      ),
      floatingActionButton: FloatingActionButtonGeneral(
        onPressed: () {
          Helper(context: context).generateAndOpenPdfFormatAll(
            listRecapitulation: viewModel.listRecapitulation,
            isRangePicked: false,
          );
        },
        icon: const Icon(Icons.print_rounded),
      ),
      body: LoadingFallback(
        isLoading: viewModel.isLoading,
        child: ListView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              itemCount: viewModel.listRecapitulation.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                ItemUserReimburseData item = viewModel.listRecapitulation[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: CardSubmission(
                    reimburseData: item,
                    isShowIcon: false,
                    onReturn: (value) {
                      viewModel.getData();
                    },
                  ),
                  // child: const CardRecapitulation(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
