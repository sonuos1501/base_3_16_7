// ignore_for_file: file_names, avoid_catches_without_on_clauses

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils.dart';

//Format nhận số thập phân đổi tất cả dấu phẩy thành dấu chấm
class CommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue,) {
    var truncated = newValue.text;
    final newSelection = newValue.selection;

    if (newValue.text.contains(',')) {
      truncated = newValue.text.replaceFirst(RegExp(','), '.');
    }
    return TextEditingValue(
      text: truncated,
      selection: newSelection,
    );
  }
}

//Chỉ nhận số nguyên dương
//WhitelistingTextInputFormatter.digitsOnly
TextInputFormatter numberTextInputFormatter() {
  return FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
}

//Chỉ nhận số có 1 dấu .
TextInputFormatter numberTextInputFormatterDoubleOnly() {
//  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"));
  return TextInputFormatter.withFunction((oldValue, newValue) {
    try {
      final text = newValue.text.replaceAll(',', '.');
      final newSelection = newValue.selection;
      if (text.isNotEmpty) {
        double.parse(text);
      }
      return TextEditingValue(text: text, selection: newSelection);
    } catch (_) {}
    return oldValue;
  });
}
// class NumberTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     String truncated = newValue.text;
//     TextSelection newSelection = newValue.selection;
//
//     if (newValue.text.contains(",")) {
//       truncated = newValue.text.replaceFirst(RegExp(','), '');
//     }
//     if (newValue.text.contains(".")) {
//       truncated = newValue.text.replaceFirst(RegExp('.'), '');
//     }
//     return TextEditingValue(
//       text: truncated,
//       selection: newSelection,
//     );
//     WhitelistingTextInputFormatter.digitsOnly
//   }
// }

//Giới hạn ký tự MaxLenght
class LengthLimitingTextFieldFormatterFixed extends LengthLimitingTextInputFormatter {
  LengthLimitingTextFieldFormatterFixed(super.maxLength);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (maxLength != null &&
        maxLength! > 0 &&
        newValue.text.characters.length > maxLength!) {
      // If already at the maximum and tried to enter even more, keep the old
      // value.
      if (oldValue.text.characters.length == maxLength) {
        return oldValue;
      }
      // ignore: invalid_use_of_visible_for_testing_member
      return LengthLimitingTextInputFormatter.truncate(newValue, maxLength!);
    }
    return newValue;
  }
}

//định dạng tiền
class CurrencyTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // remove characters to convert the value to double (because one of those may appear in the keyboard)
    final newText = newValue.text
      .replaceAll('.', '')
      .replaceAll(',', '')
      .replaceAll('_', '')
      .replaceAll('-', '');
    var value = newText;
    var cursorPosition = newText.length;
    if (newText.isNotEmpty) {
      value = Utils.intToPriceDouble(int.parse(newText));
      cursorPosition = value.length;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: cursorPosition),);
  }
}

//Định dạng số dương
class PositiveNumbersTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // remove characters to convert the value to double (because one of those may appear in the keyboard)
    var newText = newValue.text
      .replaceAll('.', '')
      .replaceAll(',', '')
      .replaceAll('_', '')
      .replaceAll('-', '');
    var value = newText;
    var cursorPosition = newText.length;

    if (newText.isNotEmpty) {
      if (newValue.text.contains(',')) {
        newText = newValue.text.replaceFirst(RegExp(','), '.');
      }
      value = Utils.doubleToString(double.parse(newText));
      cursorPosition = value.length;
    }
    return TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: cursorPosition),);
  }
}
