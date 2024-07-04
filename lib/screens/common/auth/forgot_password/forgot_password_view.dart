import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/screens/common/auth/forgot_password/forgot_password_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/appbar_general.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/button_text.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ForgotPasswordViewModel(),
      builder: (context, child) => const ForgotPasswordView(),
    );
  }
}

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ForgotPasswordViewModel>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarGeneral(
        context: context,
        title: 'Ubah Password',
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 24),
          const Text(
            'Masukkan alamat email Anda untuk menerima tautan pembaruan kata sandi.',
            style: TextStyle(
              fontWeight: Constant.lightWeightText,
            ),
          ),
          const SizedBox(height: 20),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormFieldText(
                  controllerName: viewModel.emailController,
                  placeholder: "Email",
                  hintText: "Masukkan email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 64,
                ),
                if (viewModel.isEmailEverSent)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Tidak menerima email? ",
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                      ButtonText(
                        isEnable: viewModel.isButtonEnabled,
                        onTap: () {},
                        text: viewModel.isButtonEnabled
                            ? 'Kirim ulang'
                            : 'Kirim ulang dalam ${viewModel.counter} detik',
                      )
                    ],
                  ),
                const SizedBox(height: 8),
                ButtonGeneral(
                  onTap: () {
                    viewModel.startTimer();
                  },
                  text: 'Kirim Email',
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
