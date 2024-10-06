import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/common/recapitulation/recapitulation_view_model.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/card_recapitulation_period.dart';
import 'package:reimburse_rb/widgets/common/empty_state_general.dart';
import 'package:reimburse_rb/widgets/common/floating_action_button_general.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';
import 'package:reimburse_rb/widgets/common/modal_recapitulation_print.dart';

class RecapitulationListMonthScreen extends StatelessWidget {
  const RecapitulationListMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecapitulationViewModel(context: context, isPeriodListMonthScreen: true),
      child: const RecapitulationListMonthView(),
    );
  }
}

class RecapitulationListMonthView extends StatelessWidget {
  const RecapitulationListMonthView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecapitulationViewModel>();
    final userProvider = context.read<UserProvider>();
    final navigationProvider = context.read<NavigationProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: userProvider.selectedRecapitulationYear ?? '',
      ),
      floatingActionButton: viewModel.listPeriod.isNotEmpty
          ? FloatingActionButtonGeneral(
              onPressed: () async {
                ModalRecapitulationPrint(
                  context: context,
                  title: 'Cetak Rekapitulasi',
                  onTapContinue: (startValue, endValue) {
                    Navigator.of(context).pop();

                    userProvider.setSelectedStartDateRangeRecap(startValue);
                    userProvider.setSelectedEndDateRangeRecap(endValue);

                    viewModel.getRecapitulationList(
                      isShowPrint: true,
                      isRangePicked: true,
                      startDate: startValue,
                      endDate: endValue,
                    );
                  },
                ).show();
              },
              icon: const Icon(Icons.print_rounded),
            )
          : null,
      body: LoadingFallback(
        isLoading: viewModel.isLoading,
        child: viewModel.listPeriod.isEmpty
            ? const Column(
                children: [
                  Spacer(),
                  EmptyStateGeneral(),
                  Spacer(),
                ],
              )
            : ListView(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    itemCount: viewModel.listPeriod.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      String item = viewModel.listPeriod[index];
                      return CardRecapitulationPeriod(
                        value: item,
                        onTap: () {
                          userProvider.setSelectedRecapitulationMonth(item);
                          navigationProvider.navigateToRecapitulationList(context: context);
                        },
                      );
                    },
                  )
                ],
              ),
      ),
    );
  }
}
