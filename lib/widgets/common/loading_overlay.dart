import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:reimburse_rb/utility/constant.dart';

// import 'package:onesmile/component/widget/constants.dart';

class LoadingFallback extends StatelessWidget {
  const LoadingFallback(
      {required this.isLoading, required this.child, this.loadingLabel = '', Key? key})
      : super(key: key);

  final Widget child;
  final bool isLoading;
  final String loadingLabel;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      color: Colors.black87,
      progressIndicator: LoadingOverlayWidget(label: loadingLabel),
      child: child,
    );
  }
}

class LoadingOverlayWidget extends StatelessWidget {
  const LoadingOverlayWidget({required this.label, Key? key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.transparent,
          width: 0.5,
        ),
        shape: BoxShape.circle,
      ),
      child: const SpinKitWaveSpinner(
        color: Constant.greenDark,
        duration: Duration(
          milliseconds: 2000,
        ),
        curve: Curves.linear,
        waveColor: Constant.greenMedium,
      ),
    );
  }
}
