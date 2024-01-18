// ignore_for_file: lines_longer_than_80_chars

import 'dart:math';

import 'package:flutter/services.dart';

abstract class InputFormatter extends TextInputFormatter {
  TextEditingValue? _lastNewValue;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    /// nothing changes, nothing to do
    if (newValue.text == _lastNewValue?.text) {
      return newValue;
    }
    _lastNewValue = newValue;

    /// remove all invalid characters
    newValue = formatValue(oldValue, newValue);

    /// current selection
    var selectionIndex = newValue.selection.end;

    /// format original string, this step would add some separator
    /// characters to original string
    final newText = formatPattern(newValue.text);

    /// count number of inserted character in new string
    var insertCount = 0;

    /// count number of original input character in new string
    var inputCount = 0;
    for (var i = 0; i < newText.length && inputCount < selectionIndex; i++) {
      final character = newText[i];
      if (isUserInput(character)) {
        inputCount++;
      } else {
        insertCount++;
      }
    }

    /// adjust selection according to number of inserted characters staying before
    /// selection
    selectionIndex += insertCount;
    selectionIndex = min(selectionIndex, newText.length);

    /// if selection is right after an inserted character, it should be moved
    /// backward, this adjustment prevents an issue that user cannot delete
    /// characters when cursor stands right after inserted characters
    if (selectionIndex - 1 >= 0 &&
        selectionIndex - 1 < newText.length &&
        !isUserInput(newText[selectionIndex - 1])) {
      selectionIndex--;
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: selectionIndex),
      composing: TextRange.empty,
    );
  }

  /// check character from user input or being inserted by pattern formatter
  bool isUserInput(String s);

  /// format user input with pattern formatter
  String formatPattern(String digits);

  /// validate user input
  TextEditingValue formatValue(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  );
}
