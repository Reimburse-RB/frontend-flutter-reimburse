import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/recapitulation/recapitulation_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/pdf_generator/api/pdf_api.dart';
import 'package:reimburse_rb/utility/pdf_generator/api/pdf_recapitulation_api.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/card_submission.dart';
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
      floatingActionButton: SizedBox(
        height: 64.0,
        width: 64.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () async {
              final pdfFile = await PdfRecapitulationApi(context: context).generatePdfAllRecap(
                listRecapitulation: viewModel.listRecapitulation,
              );

              log('generate pdf $pdfFile');
              PdfApi.openFile(pdfFile);
            },
            child: const Icon(Icons.print_rounded),
            backgroundColor: Constant.green,
            elevation: 8.0,
          ),
        ),
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
