import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/button_text.dart';
import 'package:reimburse_rb/widgets/common/custom_text_input.dart';
import 'package:reimburse_rb/screens/auth/signin/signin_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return SignInViewModel();
      },
      builder: (context, child) => const SignInView(),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignInViewModel>();
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
              "Masuk Akun",
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
                    placeholder: "Password",
                    hintText: "Masukkan password",
                    keyboardType: TextInputType.text,
                    isObsecure: viewModel.isObscured,
                    suffixIcon: InkWell(
                      onTap: () {
                        viewModel.onChangeIsObscuredText();
                      },
                      child: Icon(viewModel.isObscured ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Belum memiliki akun? ",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      ButtonText(
                        onTap: () {
                          viewModel.navigateToSignUpScreen(context: context);
                        },
                        text: 'Daftar Akun',
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ButtonGeneral(
                    onTap: () {
                      SignInViewModel.onCallBackLogin(context: context);
                    },
                    text: 'Masuk',
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
