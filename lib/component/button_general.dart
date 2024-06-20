import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class ButtonGeneral extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final bool isHasFlexibleWidth;

  const ButtonGeneral({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = Constant.green, // Default greenDark color
    this.textColor = Colors.white,
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: Constant.boldText,
    ),
    this.isHasFlexibleWidth = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        clipBehavior: Clip.hardEdge,
        child: Text(
          text,
          style: textStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}
