import 'dart:math';
import 'package:flutter/services.dart';

import 'input_formatter.dart';

class CreditCardFormatter extends InputFormatter {
  CreditCardFormatter({this.separator = ' '});
  static final RegExp _digitOnlyRegex = RegExp(r'\d+');
  static final FilteringTextInputFormatter _digitOnlyFormatter =
      FilteringTextInputFormatter.allow(_digitOnlyRegex);

  final String separator;

  @override
  String formatPattern(String digits) {
    final buffer = StringBuffer();
    var offset = 0;
    int count = min(4, digits.length);
    final length = digits.length;
    for (; count <= length; count += min(4, max(1, length - count))) {
      buffer.write(digits.substring(offset, count));
      if (count < length) {
        buffer.write(separator);
      }
      offset = count;
    }
    return buffer.toString();
  }

  @override
  TextEditingValue formatValue(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return _digitOnlyFormatter.formatEditUpdate(oldValue, newValue);
  }

  @override
  bool isUserInput(String s) {
    return _digitOnlyRegex.firstMatch(s) != null;
  }
}
