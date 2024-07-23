import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class FloatingActionButtonGeneral extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;

  const FloatingActionButtonGeneral({
    Key? key,
    this.icon = const Icon(
      Icons.add_rounded,
      size: 32,
    ),
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.0,
      width: 64.0,
      child: FittedBox(
        child: FloatingActionButton(
          onPressed: onPressed,
          child: icon,
          backgroundColor: Constant.green,
          elevation: 8.0,
        ),
      ),
    );
  }
}
