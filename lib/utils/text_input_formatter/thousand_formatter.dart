// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'input_formatter.dart';

class ThousandsFormatter extends InputFormatter {
  ThousandsFormatter({this.formatter, this.allowFraction = false})
      : _decimalSeparator = (formatter ?? _formatter).symbols.DECIMAL_SEP,
        _decimalRegex = RegExp(
          allowFraction
              ? '[0-9]+([${(formatter ?? _formatter).symbols.DECIMAL_SEP}])?'
              : r'\d+',
        ),
        _decimalFormatter = FilteringTextInputFormatter.allow(
          RegExp(
            allowFraction
                ? '[0-9]+([${(formatter ?? _formatter).symbols.DECIMAL_SEP}])?'
                : r'\d+',
          ),
        );
  static final NumberFormat _formatter = NumberFormat.decimalPattern();

  final FilteringTextInputFormatter _decimalFormatter;
  final String _decimalSeparator;
  final RegExp _decimalRegex;

  final NumberFormat? formatter;
  final bool allowFraction;

  @override
  String formatPattern(String? digits) {
    if (digits == null || digits.isEmpty) {
      return '';
    }
    num number;
    if (allowFraction) {
      var decimalDigits = digits;
      if (_decimalSeparator != '.') {
        decimalDigits = digits.replaceFirst(RegExp(_decimalSeparator), '.');
      }
      number = double.tryParse(decimalDigits) ?? 0.0;
    } else {
      number = int.tryParse(digits) ?? 0;
    }
    final result = (formatter ?? _formatter).format(number);
    if (allowFraction && digits.endsWith(_decimalSeparator)) {
      return '$result$_decimalSeparator';
    }
    return result;
  }

  @override
  TextEditingValue formatValue(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return _decimalFormatter.formatEditUpdate(oldValue, newValue);
  }

  @override
  bool isUserInput(String s) {
    return s == _decimalSeparator || _decimalRegex.firstMatch(s) != null;
  }
}
