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
import 'package:reimburse_rb/widgets/employee/card_detail_cost.dart';

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

class SubmissionFormView extends StatelessWidget {
  const SubmissionFormView({super.key});

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
                          userProvider.selectedReimbursementCategory?.categoryReimbursementId == 1
                              ? 'Pilih Diagnosis'
                              : 'Pilih Tujuan',
                      value: viewModel.selectedPurpose,
                      items: viewModel.listPurposeOption ?? [],
                      placeholder:
                          userProvider.selectedReimbursementCategory?.categoryReimbursementId == 1
                              ? 'Diagnosis'
                              : 'Tujuan',
                      onChanged: (newValue) {
                        viewModel.changePurpose(newSelectedPurpose: newValue);
                      },
                    ),
                    const SizedBox(height: 16),
                    FormFieldText(
                      placeholder: "Total Biaya",
                      isEnabled: false,
                      hintText: "Total Biaya Otomatis",
                      keyboardType: TextInputType.number,
                      controllerName: viewModel.totalCostController,
                      isCost: true,
                      note: "Catatan: Total Biaya akan terisi otomatis oleh sistem",
                      noteStyle: Constant.regularNoteStyle,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const FormImageAttachment(
              title: 'Lampiran Bukti',
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
                  child: CardDetailCost(
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
                  color: Colors.white,
                ),
                color: Constant.greenDark,
                text: 'Tambahkan Rincian',
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
