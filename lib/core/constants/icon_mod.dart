import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconMod extends StatelessWidget {
  final String name;      // Sadece ikonun adı (örn: 'home')
  final Color? color;     // İkon rengi
  final String level;     // 'xs', 's', 'm', 'l', 'xl'
  final double? customSize; // Eğer özel bir boyut gerekirse

  const IconMod(
      this.name, {
        super.key,
        this.color,
        this.level = 'm',
        this.customSize,
      });

  double _getIconSize(String level) {
    switch (level) {
      case 'xs': return 16.0;
      case 's':  return 20.0;
      case 'm':  return 24.0;
      case 'l':  return 32.0;
      case 'xl': return 48.0;
      default:   return 24.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double finalSize = customSize ?? _getIconSize(level);

    return SvgPicture.asset(
      'assets/icons/$name.svg',
      width: finalSize,
      height: finalSize,

      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,

      placeholderBuilder: (context) => SizedBox(width: finalSize, height: finalSize),
    );
  }
}