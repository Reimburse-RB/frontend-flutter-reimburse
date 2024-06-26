import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/term_condition_data.dart';
import 'package:reimburse_rb/screens/employee/term_condition_view/term_condition_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';

class TermConditionScreen extends StatelessWidget {
  const TermConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TermConditionViewModel>(
      create: (_) => TermConditionViewModel(),
      child: const TermConditionView(),
    );
  }
}

class TermConditionView extends StatelessWidget {
  const TermConditionView({super.key});

  Widget buildTermConditionCategory(TermConditionViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        itemCount: viewModel.termConditionList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          TermConditionData termCategory = viewModel.termConditionList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                termCategory.title,
                style: Constant.mainTitleStyle,
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: termCategory.listTnc.length,
                itemBuilder: (context, index) {
                  String term = termCategory.listTnc[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${index + 1}.'),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            term,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TermConditionViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Syarat & Ketentuan',
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          buildTermConditionCategory(viewModel),
        ],
      ),
    );
  }
}
