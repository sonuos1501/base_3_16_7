// ignore_for_file: file_names

import 'dart:convert';
import 'package:crypto/crypto.dart';

extension StringExtend on String {
  String base64Encode() {
    final stringToBase64 = utf8.fuse(base64);
    return stringToBase64.encode(this);
  }

  String base64Decode() {
    final stringToBase64 = utf8.fuse(base64);
    return stringToBase64.decode(this);
  }

  int? toInt() {
    return int.tryParse(this);
  }

  double? toDouble() {
    return double.tryParse(this);
  }

  String toMd5() {
    return md5.convert(utf8.encode(this)).toString();
  }

  bool isNumber() {
    final numeric = RegExp(r'^-?[0-9]+$');

    /// check if the string contains only numbers
    return numeric.hasMatch(this);
  }
}
