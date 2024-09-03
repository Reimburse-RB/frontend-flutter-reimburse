import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class FormSmallNote extends StatelessWidget {
  const FormSmallNote({
    super.key,
    required this.note,
    this.prefixIcon,
    this.noteTextStyle = Constant.regularNoteStyle,
    this.isHasBackground = false,
    this.backgroundPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    this.backgroundRadius = 16,
    this.backgroundBorder,
    this.backgroundColor,
  });

  final bool isHasBackground;
  final Color? backgroundColor;
  final EdgeInsets backgroundPadding;
  final double backgroundRadius;
  final Border? backgroundBorder;
  final String note;
  final Widget? prefixIcon;
  final TextStyle noteTextStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isHasBackground ? backgroundPadding : null,
      decoration: isHasBackground
          ? BoxDecoration(
              // color: backgroundColor ?? Colors.grey.shade50,
              borderRadius: BorderRadius.circular(backgroundRadius),
              border: backgroundBorder ?? Border.all(width: 1, color: Constant.greenDark),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (prefixIcon != null)
            Container(
              margin: EdgeInsets.only(right: 12),
              child: prefixIcon,
            ),
          Flexible(
            child: Text(
              note,
              style: noteTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
