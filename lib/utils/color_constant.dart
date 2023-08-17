import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color mainOrange = fromHex('#ff660e');

  static Color mattBlack = fromHex('#202020');

  static Color darkGrey = fromHex('#999999');

  static Color mediumGrey = fromHex('#E3E3E3');

  static Color lightGrey = fromHex('#f5f5f5');



  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
