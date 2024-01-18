// ignore_for_file: file_names
import 'dart:ui';

import '../Extends/ColorExtends.dart';


class ResourceUtil {
  static const _pathResource = 'assets/';

  static String image(String name) {
    if (name.contains('.')) {
      return '${_pathResource}images/$name';
    }
    return '${_pathResource}images/$name.png';
  }

  static String icon(String name) {
    if (name.contains('.')) {
      return '${_pathResource}icons/$name';
    }
    return '${_pathResource}icons/$name.svg';
  }

  static String logo(String name) {
    if (name.contains('.')) {
      return '${_pathResource}logo/$name';
    }
    return '${_pathResource}logo/$name.svg';
  }

  static Color hexToColor(String code) {
    //return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
    return ColorExtends(code);
  }

  static String gif(String name) {
    if (name.contains('.')) {
      return '${_pathResource}gif/$name';
    }
    return '${_pathResource}gif/$name.gif';
  }

}
