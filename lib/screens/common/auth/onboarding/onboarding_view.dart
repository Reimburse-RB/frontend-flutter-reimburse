import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/onboard_data.dart';
import 'package:reimburse_rb/screens/common/auth/onboarding/onboarding_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return OnboardingViewModel();
      },
      builder: (context, child) => const OnboardingScreenView(),
    );
  }
}

class OnboardingScreenView extends StatelessWidget {
  const OnboardingScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          viewModel.onBoardingClose(context: context);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Stack(
            children: [
              viewModel.onboardDataList.isNotEmpty
                  ? PageView.builder(
                      controller: viewModel.pageBoardController,
                      onPageChanged: (value) {
                        viewModel.onPageChanged(value);
                      },
                      itemCount: viewModel.onboardDataList.length,
                      itemBuilder: (context, index) {
                        OnboardData item = viewModel.onboardDataList[index];
                        return OnboardingContent(title: item.desc, image: item.image);
                      },
                    )
                  : const SizedBox(),
              const Positioned(
                bottom: 48,
                left: 0,
                right: 0,
                child: OnboardingBottomButton(),
              ),
            ],
          )),
        ));
  }
}

class OnboardingBottomButton extends StatelessWidget {
  const OnboardingBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          if (viewModel.currentPage != viewModel.onboardDataList.length - 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                viewModel.onboardDataList.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 5),
                  height: viewModel.currentPage == index ? 10 : 8,
                  width: viewModel.currentPage == index ? 10 : 8,
                  decoration: BoxDecoration(
                      color: viewModel.currentPage == index
                          ? Constant.greenDark
                          : Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          if (viewModel.currentPage == viewModel.onboardDataList.length - 1)
            ButtonGeneral(
              onTap: () {
                viewModel.onTapNextPage(context: context);
              },
              text: 'Mulai Sekarang',
            ),
        ],
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);
  final String title, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            image,
            height: MediaQuery.of(context).size.width * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ],
      ),
    );
  }
}
