import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/component/button_general.dart';
import 'package:reimburse_rb/component/button_text.dart';
import 'package:reimburse_rb/component/custom_text_input.dart';
import 'package:reimburse_rb/module/auth/screen/signup/signup_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (context) {
        return SignUpViewModel();
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
                  CustomTextInput(
                    controllerName: viewModel.nameController,
                    placeholder: "Nama Lengkap",
                    hintText: "Masukkan nama lengkap",
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextInput(
                    controllerName: viewModel.nameController,
                    placeholder: "Nomor Induk Karyawan (NIK)",
                    hintText: "Masukkan nomor induk karyawan",
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextInput(
                    controllerName: viewModel.emailController,
                    placeholder: "Email",
                    hintText: "Masukkan email",
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextInput(
                    controllerName: viewModel.passwordController,
                    placeholder: "Password Baru",
                    hintText: "Masukkan password",
                    keyboardType: TextInputType.text,
                    isObsecure: viewModel.isObscured1,
                    suffixIcon: InkWell(
                      onTap: () {
                        viewModel.onChangeIsObscuredText1();
                      },
                      child: Icon(viewModel.isObscured1 ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextInput(
                    controllerName: viewModel.confirmPasswordController,
                    placeholder: "Konfirmasi Password",
                    hintText: "Masukkan password",
                    keyboardType: TextInputType.text,
                    isObsecure: viewModel.isObscured2,
                    suffixIcon: InkWell(
                      onTap: () {
                        viewModel.onChangeIsObscuredText2();
                      },
                      child: Icon(viewModel.isObscured2 ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
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
                  ButtonGeneral(onTap: () {}, text: 'Daftar'),
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
