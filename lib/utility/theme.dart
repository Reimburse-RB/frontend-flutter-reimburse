import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reimburse_rb/utility/constant.dart';

enum MyTheme { light, dark }

// notes status bar
// Brightness.light > bg white & text black
// Brightness.dark > bg black & text white

class ThemeNotifier with ChangeNotifier {
  static List<ThemeData> themes = [
    ThemeData(
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        color: Constant.greenDark,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(),
        bodySmall: GoogleFonts.poppins(),
        bodyMedium: GoogleFonts.poppins(),
        displayLarge: GoogleFonts.poppins(),
        displayMedium: GoogleFonts.poppins(),
        displaySmall: GoogleFonts.poppins(),
        headlineLarge: GoogleFonts.poppins(),
        headlineMedium: GoogleFonts.poppins(),
        headlineSmall: GoogleFonts.poppins(),
        labelLarge: GoogleFonts.poppins(),
        labelMedium: GoogleFonts.poppins(),
        labelSmall: GoogleFonts.poppins(),
        titleLarge: GoogleFonts.poppins(),
        titleSmall: GoogleFonts.poppins(),
        titleMedium: GoogleFonts.poppins(),
      ),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
              accentColor: Constant.greenDark,
              brightness: Brightness.light)
          .copyWith(
        surface: Colors.white,
        brightness: Brightness.light,
      ),
      datePickerTheme: const DatePickerThemeData(
        backgroundColor: Constant.greenMoreVeryLight,
        headerBackgroundColor: Constant.greenDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        // headerTextStyle: TextStyle(color: Colors.white),
        // dayStyle: TextStyle(color: Constant.greenDark),
        // selectedDayStyle: TextStyle(color: Colors.white),
        // selectedDayBackgroundColor: Constant.greenMedium,
        // weekendStyle: TextStyle(color: Constant.greenLight),
      ),
    ),
    ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.green,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(),
        bodySmall: GoogleFonts.poppins(),
        bodyMedium: GoogleFonts.poppins(),
        displayLarge: GoogleFonts.poppins(),
        displayMedium: GoogleFonts.poppins(),
        displaySmall: GoogleFonts.poppins(),
        headlineLarge: GoogleFonts.poppins(),
        headlineMedium: GoogleFonts.poppins(),
        headlineSmall: GoogleFonts.poppins(),
        labelLarge: GoogleFonts.poppins(),
        labelMedium: GoogleFonts.poppins(),
        labelSmall: GoogleFonts.poppins(),
        titleLarge: GoogleFonts.poppins(),
        titleSmall: GoogleFonts.poppins(),
        titleMedium: GoogleFonts.poppins(),
      ),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.green,
              accentColor: Constant.greenMedium,
              brightness: Brightness.dark)
          .copyWith(background: Colors.black),
    ),
  ];

  MyTheme _current = MyTheme.light;
  ThemeData _currentTheme = themes[0];

  void switchTheme() =>
      currentTheme == MyTheme.light ? currentTheme = MyTheme.dark : currentTheme = MyTheme.light;

  set currentTheme(theme) {
    if (theme != null) {
      _current = theme;
      _currentTheme = _current == MyTheme.light ? themes[0] : themes[1];

      notifyListeners();
    }
  }

  get currentTheme => _current;
  get currentThemeData => _currentTheme;
}
