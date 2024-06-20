import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color textColor;
  final Color decorationColor;
  final double fontSize;
  final FontWeight fontWeight;
  final double decorationThickness;

  const ButtonText({
    Key? key,
    required this.onTap,
    required this.text,
    this.textColor = Colors.green, // Default color
    this.decorationColor = Colors.green, // Default decoration color
    this.fontSize = 13.0,
    this.fontWeight = FontWeight.w500, // Default medium weight
    this.decorationThickness = 1.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: TextStyle(
          decoration: TextDecoration.underline,
          decorationColor: decorationColor,
          decorationThickness: decorationThickness,
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
