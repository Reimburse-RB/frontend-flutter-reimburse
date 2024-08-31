import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/recapitulation/recapitulation_view_model.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/card_recapitulation_period.dart';
import 'package:reimburse_rb/widgets/common/empty_state_general.dart';
import 'package:reimburse_rb/widgets/common/floating_action_button_general.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';
import 'package:reimburse_rb/widgets/common/modal_date_range.dart';

class RecapitulationListYearScreen extends StatelessWidget {
  const RecapitulationListYearScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecapitulationViewModel(context: context, isPeriodListYearScreen: true),
      child: const RecapitulationListYearView(),
    );
  }
}

class RecapitulationListYearView extends StatelessWidget {
  const RecapitulationListYearView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RecapitulationViewModel>();
    final userProvider = context.read<UserProvider>();
    final navigationProvider = context.read<NavigationProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Rekapitulasi Reimbursement',
      ),
      floatingActionButton: FloatingActionButtonGeneral(
        onPressed: () async {
          ModalDateRange(
            context: context,
            title: 'Pilih Periode',
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
      ),
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
                          navigationProvider.navigateToRecapitulationPeriodMonth(
                            context: context,
                            year: item,
                          );
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
