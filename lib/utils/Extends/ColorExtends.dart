// ignore_for_file: file_names, prefer_single_quotes, avoid_final_parameters, parameter_assignments

import 'dart:ui';

class ColorExtends extends Color {

  ColorExtends(String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }
}
