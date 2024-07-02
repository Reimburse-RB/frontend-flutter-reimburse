import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/screens/employee/recapitulation/recapitulation_view_model.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/card_recapitulation_period.dart';

class RecapitulationListPeriodScreen extends StatelessWidget {
  const RecapitulationListPeriodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecapitulationViewModel(context: context),
      child: const RecapitulationListPeriodView(),
    );
  }
}

class RecapitulationListPeriodView extends StatelessWidget {
  const RecapitulationListPeriodView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecapitulationViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Rekapitulasi Reimbursement',
      ),
      body: ListView(
        children: [
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return CardRecapitulationPeriod(
                onTap: () {
                  viewModel.navigateToRecapitulationList();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
