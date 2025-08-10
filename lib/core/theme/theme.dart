import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

AppColors colors = AppColors();

@immutable
class AppTheme {

  const AppTheme._();

  static ThemeData lightTheme = ThemeData(
      primaryColor: colors.blackBg,
      useMaterial3: false,
      fontFamily: "FontMedium",
      scaffoldBackgroundColor: colors.whiteBg,

  );

  static ThemeData darkTheme = ThemeData(
      primaryColor: colors.whiteBg,
      useMaterial3: false,
      fontFamily: "FontMedium",
      scaffoldBackgroundColor: colors.blackBg,
  );
}