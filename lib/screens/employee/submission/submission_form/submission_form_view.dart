import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view_model.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/form_dropdown_purpose.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';

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
    final provider = context.watch<UserProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Formulir Reimbursement',
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
                      placeholder: "Nama Karyawan",
                      hintText: "Masukkan Nama Karyawan",
                      initialValue: provider.profileData?.name,
                      isEnabled: false,
                    ),
                    const SizedBox(height: 16),
                    FormDropdownPurpose(
                      hintText: 'Pilih Diagnosis',
                      items: viewModel.listPurposeOption ?? [],
                      placeholder: 'Diagnosis',
                      onChanged: (newValue) {
                        viewModel.changePurpose(selectedPurpose: newValue);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
