import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class ButtonGeneral extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color color;
  final Color textColor;
  final Color inactiveButtonColor;
  final Color inactiveTextColor;
  final double borderRadius;
  final EdgeInsets padding;
  final TextStyle textStyle;
  final bool isHasFlexibleWidth;
  final bool isWhiteButton;
  final bool isButtonActive;
  final Widget? prefixIcon;

  const ButtonGeneral({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = Constant.green, // Default greenDark color
    this.textColor = Colors.white,
    this.inactiveButtonColor = Constant.grey,
    this.inactiveTextColor = Colors.white,
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: Constant.boldText,
    ),
    this.isHasFlexibleWidth = true,
    this.isWhiteButton = false,
    this.isButtonActive = true,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isButtonActive ? onTap : null,
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        decoration: BoxDecoration(
          color: isButtonActive
              ? isWhiteButton
                  ? Colors.white
                  : color
              : inactiveButtonColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: isWhiteButton
              ? Border.all(
                  width: 1.5,
                  color: Constant.green,
                )
              : null,
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null)
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: prefixIcon,
              ),
            Text(
              text,
              style: textStyle.copyWith(
                color: isButtonActive
                    ? isWhiteButton
                        ? Constant.green
                        : textColor
                    : inactiveTextColor,
                fontWeight: Constant.boldText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
