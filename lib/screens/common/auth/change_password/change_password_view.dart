import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/screens/common/auth/change_password/change_password_view_model.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordViewModel(context: context),
      builder: (context, child) => const ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChangePasswordViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Ubah Password',
      ),
      body: LoadingFallback(
        isLoading: viewModel.isLoading,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 24),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FormFieldText(
                    controllerName: viewModel.oldPasswordController,
                    placeholder: "Password Lama",
                    hintText: "Masukkan password lama",
                    keyboardType: TextInputType.text,
                    isObsecure: viewModel.isObscured1,
                    suffixIcon: InkWell(
                      onTap: () {
                        viewModel.changeIsObscuredText1();
                      },
                      child: Icon(viewModel.isObscured1 ? Icons.visibility : Icons.visibility_off),
                    ),
                    onChanged: (value) {
                      viewModel.checkAllField();
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormFieldText(
                    controllerName: viewModel.newPasswordController,
                    placeholder: "Password Baru",
                    hintText: "Masukkan password baru",
                    keyboardType: TextInputType.text,
                    isObsecure: viewModel.isObscured2,
                    suffixIcon: InkWell(
                      onTap: () {
                        viewModel.changeIsObscuredText2();
                      },
                      child: Icon(viewModel.isObscured2 ? Icons.visibility : Icons.visibility_off),
                    ),
                    onChanged: (value) {
                      viewModel.checkAllField();
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  ButtonGeneral(
                    onTap: () {
                      viewModel.postChangePassword();
                    },
                    text: 'Ubah Password',
                    isButtonActive: viewModel.isButtonEnabled,
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
