import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/button_text.dart';
import 'package:reimburse_rb/widgets/common/form_dropdown_role.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';
import 'package:reimburse_rb/screens/common/auth/signup/signup_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/loading_overlay.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (context) {
        return SignUpViewModel(context: context);
      },
      builder: (context, child) => const SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LoadingFallback(
          isLoading: viewModel.isLoading,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Image.asset(
                'assets/apps_logo/logo-horizontal-reimburserb.png',
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
                height: 72,
                // height: MediaQuery.of(context).size.height,
              ),
              const SizedBox(
                height: 48,
              ),
              const Text(
                "Daftar Akun",
                style: TextStyle(
                  fontWeight: Constant.semiBoldText,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FormFieldText(
                      controllerName: viewModel.nameController,
                      placeholder: "Nama Lengkap",
                      hintText: "Masukkan nama lengkap",
                      keyboardType: TextInputType.name,
                      onChanged: (newValue) {
                        viewModel.checkAllField();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FormFieldText(
                      controllerName: viewModel.nikController,
                      placeholder: "Nomor Induk Karyawan (NIK)",
                      hintText: "Masukkan nomor induk karyawan",
                      keyboardType: TextInputType.name,
                      onChanged: (newValue) {
                        viewModel.checkAllField();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FormFieldText(
                      controllerName: viewModel.emailController,
                      placeholder: "Email",
                      hintText: "Masukkan email",
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (newValue) {
                        viewModel.checkAllField();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FormDropdownRole(
                      hintText: 'Pilih Role',
                      placeholder: 'Role',
                      items: viewModel.listRole,
                      value: viewModel.selectedRole,
                      onChanged: (newSelectedRole) {
                        viewModel.changeRole(newSelectedRole!);
                        viewModel.checkAllField();
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FormFieldText(
                      controllerName: viewModel.passwordController,
                      placeholder: "Password Baru",
                      hintText: "Masukkan password",
                      keyboardType: TextInputType.text,
                      isObsecure: viewModel.isObscured1,
                      suffixIcon: InkWell(
                        onTap: () {
                          viewModel.changeIsObscuredText1();
                        },
                        child:
                            Icon(viewModel.isObscured1 ? Icons.visibility : Icons.visibility_off),
                      ),
                      onChanged: (newPassword) {
                        viewModel.checkIsPasswordMatch();
                        viewModel.checkAllField();
                      },
                      note: viewModel.isPasswordMatch ? '' : 'Password tidak cocok',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FormFieldText(
                      controllerName: viewModel.confirmPasswordController,
                      placeholder: "Konfirmasi Password",
                      hintText: "Masukkan password",
                      keyboardType: TextInputType.text,
                      isObsecure: viewModel.isObscured2,
                      suffixIcon: InkWell(
                        onTap: () {
                          viewModel.changeIsObscuredText2();
                        },
                        child:
                            Icon(viewModel.isObscured2 ? Icons.visibility : Icons.visibility_off),
                      ),
                      onChanged: (confirmPassword) {
                        viewModel.checkIsPasswordMatch();
                        viewModel.checkAllField();
                      },
                      note: viewModel.isPasswordMatch ? '' : 'Password tidak cocok',
                    ),
                    const SizedBox(
                      height: 64,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Sudah memiliki akun? ",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                        ),
                        ButtonText(
                          onTap: () {
                            viewModel.navigateToLoginScreen(context: context);
                          },
                          text: 'Masuk Akun',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ButtonGeneral(
                      onTap: () {
                        viewModel.submitSignUp();
                      },
                      text: 'Daftar',
                      isButtonActive: viewModel.isReadyToSubmit,
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
