import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/form_dropdown_purpose.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';
import 'package:reimburse_rb/widgets/common/form_image_attachment.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';
import 'package:reimburse_rb/widgets/employee/card_form_detail_cost.dart';

class SubmissionFormScreen extends StatelessWidget {
  const SubmissionFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SubmissionFormViewModel>(
      create: (context) => SubmissionFormViewModel(context: context),
      child: const SubmissionFormView(),
    );
  }
}

class SubmissionFormView extends StatefulWidget {
  const SubmissionFormView({super.key});

  @override
  State<SubmissionFormView> createState() => _SubmissionFormViewState();
}

class _SubmissionFormViewState extends State<SubmissionFormView> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SubmissionFormViewModel>();
    final userProvider = context.read<UserProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Reimburse ${userProvider.selectedReimbursementCategory?.categoryReimbursementText}',
      ),
      body: LoadingFallback(
        isLoading: viewModel.isLoading,
        child: ListView(
          children: [
            const SizedBox(height: 24),
            Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormFieldText(
                      controllerName: viewModel.nameController,
                      placeholder: "Nama Karyawan",
                      hintText: "Masukkan Nama Karyawan",
                      isEnabled: false,
                    ),
                    const SizedBox(height: 16),
                    FormDropdownPurpose(
                      hintText:
                          userProvider.selectedReimbursementCategory?.categoryReimbursementId ==
                                  Constant.healthCategoryReimbursementId
                              ? 'Pilih Diagnosis'
                              : 'Pilih Tujuan',
                      value: viewModel.selectedPurpose,
                      items: viewModel.listPurposeOption ?? [],
                      placeholder:
                          userProvider.selectedReimbursementCategory?.categoryReimbursementId ==
                                  Constant.healthCategoryReimbursementId
                              ? 'Diagnosis'
                              : 'Tujuan',
                      onChanged: (newValue) {
                        viewModel.onChangePurpose(newSelectedPurpose: newValue);
                      },
                    ),
                    if (viewModel.selectedPurpose?.purpose_id == 1) ...[
                      const SizedBox(height: 8),
                      FormFieldText(
                        controllerName: viewModel.otherPurposeController,
                        hintText:
                            userProvider.selectedReimbursementCategory?.categoryReimbursementId ==
                                    Constant.healthCategoryReimbursementId
                                ? 'Masukkan Diagnosis Lain'
                                : 'Masukkan Tujuan Lain',
                        // note: userProvider.selectedReimbursementCategory?.categoryReimbursementId ==
                        //         Constant.healthCategoryReimbursementId
                        //     ? Constant.noteFormPurposeHealth
                        //     : Constant.noteFormPurposeTransport,
                        // prefixIconNote: Icon(
                        //   Icons.info_rounded,
                        //   color: Constant.waitingStatusColor,
                        // ),
                      ),
                    ],
                    const SizedBox(height: 16),
                    FormFieldText(
                      placeholder: "Total Biaya",
                      isEnabled: false,
                      hintText: "Total Biaya Otomatis",
                      keyboardType: TextInputType.number,
                      controllerName: viewModel.totalCostController,
                      isCost: true,
                      note: Constant.noteFormTotalCost,
                      prefixIconNote: Icon(
                        Icons.info_rounded,
                        color: Constant.waitingStatusColor,
                      ),
                      noteStyle: Constant.regularNoteStyle,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            FormImageAttachment(
              title: 'Lampiran Bukti',
              viewModel: viewModel,
              onTapAddImage: () {
                viewModel.onTapAddImage(animationController: animationController);
              },
            ),
            const SizedBox(height: 24),
            ListView.builder(
              itemCount: viewModel.listBodyDetailCost.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: CardFormDetailCost(
                    viewModel: viewModel,
                    detailCostIndex: index,
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ButtonGeneral(
                onTap: () {
                  viewModel.addDetailCost();
                },
                prefixIcon: const Icon(
                  Icons.add_rounded,
                  color: Constant.green,
                ),
                isWhiteButton: true,
                color: Constant.greenDark,
                text: 'Tambahkan Rincian',
              ),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ButtonGeneral(
                onTap: () {
                  viewModel.postUploadSubmission();
                },
                color: Constant.greenDark,
                text: 'Unggah Pengajuan',
              ),
            ),
            const SizedBox(height: 72),
          ],
        ),
      ),
    );
  }
}
