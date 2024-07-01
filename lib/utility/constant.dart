import 'package:flutter/material.dart';

class Constant {
  static String randomImageUrl = 'https://picsum.photos/200';

  static const Color greenDark = Color(0xFF004D34);
  static const Color greenMedium = const Color.fromRGBO(17, 143, 82, 1);
  static const Color green = Color(0xFF216600);
  static const Color greenLight = Color(0xFFC1FFC0);
  static const Color greenMoreLight = const Color.fromRGBO(190, 255, 224, 1);
  static const Color greenMoreVeryLight = Color(0xFFF6FFF5);

  static const Color grey = Color(0xFFA8A8A8);

  static const Color waitingStatusColor = Color(0xFFFFC107);
  static const Color processStatusIconColor = Color(0xFF0021F5);
  static const Color processStatusTextColor = Color(0xFF020064);
  static const Color acceptedStatusIconColor = Color(0xFF13EC00);
  static const Color acceptedStatusTextColor = Color(0xFF134A00);
  static const Color rejectedStatusColor = Color(0xFFEB3223);
  static const Color limitColor = Colors.deepOrange;

  static const FontWeight extraBoldText = FontWeight.w800;
  static const FontWeight boldText = FontWeight.w700;
  static const FontWeight semiBoldText = FontWeight.w600;
  static const FontWeight mediumWeightText = FontWeight.w500;
  static const FontWeight normalWeightText = FontWeight.w400;
  static const FontWeight lightWeightText = FontWeight.w300;
  static const FontWeight extraLightWeightText = FontWeight.w200;

  static const TextStyle mainTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: boldText,
  );
  static const TextStyle secondTitleStyle = TextStyle(
    fontSize: 16,
    fontWeight: boldText,
  );
}
