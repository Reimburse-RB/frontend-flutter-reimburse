import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/term_condition_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/common/term_condition/term_condition_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/bottom_appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/floating_action_button_general.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';

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
        itemCount: viewModel.termConditionCategoryList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          TermConditionCategoryData termCategory = viewModel.termConditionCategoryList[index];
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
                physics: NeverScrollableScrollPhysics(),
                itemCount: termCategory.list_tnc.length,
                itemBuilder: (context, index) {
                  String term = termCategory.list_tnc[index].tnc;
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
        itemCount: viewModel.termConditionCategoryList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, categoryIndex) {
          TermConditionCategoryData termCategory =
              viewModel.termConditionCategoryList[categoryIndex];
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
                itemCount: termCategory.list_tnc.length,
                itemBuilder: (context, conditionIndex) {
                  String term = termCategory.list_tnc[conditionIndex].tnc;
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
              const SizedBox(height: 12),
              ButtonGeneral(
                onTap: () {
                  viewModel.addCondition(categoryIndex: categoryIndex, condition: '');
                },
                isWhiteButton: true,
                prefixIcon: const Icon(
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
    final userProvider = context.read<UserProvider>();
    return PopScope(
      canPop: !viewModel.isEditing,
      onPopInvokedWithResult: !viewModel.isEditing
          ? null
          : (viewModel.isEditing)
              ? (didPop, result) async {
                  if (didPop) return;
                  final bool shouldPop =
                      await Helper(context: context).showCustomDialog(context: context) ?? false;

                  if (context.mounted && shouldPop) {
                    Navigator.pop(context);
                  }
                }
              : null,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarGeneral(
          context: context,
          title: 'Syarat & Ketentuan',
          onBack: viewModel.isEditing
              ? () async {
                  final bool shouldPop =
                      await Helper(context: context).showCustomDialog(context: context) ?? false;

                  if (context.mounted && shouldPop) {
                    Navigator.pop(context);
                  }
                }
              : () {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
        ),
        bottomNavigationBar: (viewModel.isEditing)
            ? BottomAppBarGeneral(
                child: Row(
                  children: [
                    Flexible(
                      child: ButtonGeneral(
                        onTap: () {
                          Helper(context: context).showCustomDialog(
                            title: 'Anda Yakin?',
                            message: Constant.confirmUnsavedAlertClose,
                            context: context,
                            firstButtonOnTap: () {
                              Navigator.of(context).pop();
                            },
                            secondButtonOnTap: () {
                              Navigator.of(context).pop();
                              viewModel.cancelEdit();
                            },
                          );
                        },
                        text: 'Batalkan',
                        isWhiteButton: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Flexible(
                      child: ButtonGeneral(
                        onTap: () {
                          viewModel.postEditTnc();
                        },
                        text: 'Simpan',
                      ),
                    ),
                  ],
                ),
              )
            : null,
        floatingActionButton:
            (!viewModel.isEditing && userProvider.isAdmin && userProvider.isAccountVerified)
                ? FloatingActionButtonGeneral(
                    onPressed: () {
                      viewModel.setChangeIsEditingValue();
                    },
                    icon: const Icon(
                      Icons.edit_rounded,
                      size: 32,
                    ),
                  )
                : null,
        body: LoadingFallback(
          isLoading: viewModel.isLoading,
          child: ListView(
            children: [
              const SizedBox(height: 24),
              viewModel.isEditing
                  ? buildEditingTermConditionCategory(viewModel)
                  : buildTermConditionCategory(viewModel),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
