import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/term_condition_data.dart';
import 'package:reimburse_rb/screens/common/term_condition/term_condition_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';

class TermConditionScreen extends StatelessWidget {
  const TermConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TermConditionViewModel>(
      create: (_) => TermConditionViewModel(context: context),
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
            key: ValueKey(termCategory.title),
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
                    key: ValueKey(term),
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

  Widget buildEditingTermConditionCategory(TermConditionViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        itemCount: viewModel.termConditionList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, categoryIndex) {
          TermConditionData termCategory = viewModel.termConditionList[categoryIndex];
          return Column(
            key: ValueKey(termCategory.title),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                termCategory.title,
                style: Constant.mainTitleStyle,
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: termCategory.listTnc.length,
                itemBuilder: (context, conditionIndex) {
                  String term = termCategory.listTnc[conditionIndex];
                  return Container(
                    key: ValueKey(term),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${conditionIndex + 1}.'),
                        const SizedBox(width: 12),
                        Expanded(
                          child: FormFieldText(
                            initialValue: term,
                            minLines: 3,
                            maxLines: 5,
                            hintText: 'Masukkan rincian syarat dan ketentuan',
                            onChanged: (value) {
                              viewModel.updateCondition(
                                categoryIndex: categoryIndex,
                                conditionIndex: conditionIndex,
                                newCondition: value,
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        InkWell(
                          onTap: () {
                            viewModel.deleteCondition(
                                categoryIndex: categoryIndex, conditionIndex: conditionIndex);
                          },
                          child: const Icon(
                            IconlyBold.delete,
                            color: Constant.rejectedStatusColor,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 12),
              ButtonGeneral(
                onTap: () {
                  viewModel.addCondition(categoryIndex: categoryIndex, condition: '');
                },
                isWhiteButton: true,
                prefixIcon: Icon(
                  Icons.add_rounded,
                  color: Constant.green,
                ),
                text: 'Tambah Syarat',
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
      floatingActionButton: SizedBox(
        height: 64.0,
        width: 64.0,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {
              viewModel.setChangeIsEditingValue();
            },
            child: const Icon(Icons.edit),
            backgroundColor: Constant.green,
            elevation: 8.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 24),
          viewModel.isEditing
              ? buildEditingTermConditionCategory(viewModel)
              : buildTermConditionCategory(viewModel),
        ],
      ),
    );
  }
}
