import 'package:flutter/material.dart';

enum AppFontSize { small, normal, large }

class FontSizeConfig {

  static double getMultiplier(AppFontSize setting) {
    switch (setting) {
      case AppFontSize.small: return 0.8;
      case AppFontSize.large: return 1.2;
      case AppFontSize.normal:
      return 1.0;
    }
  }

  static double getBaseSize(String level) {
    switch (level) {
      case 'xs': return 12.0;
      case 's':  return 14.0;
      case 'm':  return 16.0;
      case 'l':  return 20.0;
      case 'xl': return 24.0;
      default:   return 16.0;
    }
  }
}

class TextMod extends StatelessWidget {
  final String text;
  final Color? color;
  final String level;
  final FontWeight weight;
  final String? fontFamily;
  final AppFontSize userFontSizePreference;

  const TextMod(
      this.text, {
        super.key,
        this.color,
        this.level = 'm',
        this.weight = FontWeight.normal,
        this.fontFamily = "FontMedium",
        this.userFontSizePreference = AppFontSize.normal,
      });

  @override
  Widget build(BuildContext context) {

    double baseSize = FontSizeConfig.getBaseSize(level);
    double finalSize = baseSize * FontSizeConfig.getMultiplier(userFontSizePreference);

    return Text(
      text,
      softWrap: true,
      maxLines: 5,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: weight,
        color: color ?? Colors.black,
        fontSize: finalSize,
      ),
    );
  }
}