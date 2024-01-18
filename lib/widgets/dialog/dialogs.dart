import 'package:flutter/material.dart';

class Dialogs {
  const Dialogs(this.context);

  final BuildContext context;

  Future<void> showSimpleDialog(String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// returns `true` when user select "OK".
  Future<bool> showConfirmDialog(String message) async {
    final dialogResult = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    // when user cancel dialog, dialogResult is null.
    return dialogResult ?? false;
  }

  Future<bool> showCustomConfirmDialog({
    required String message,
    required String negativeMessage,
    required String positiveMessage,
  }) async {
    final dialogResult = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(negativeMessage),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(positiveMessage),
            ),
          ],
        );
      },
    );

    // when user cancel dialog, dialogResult is null.
    return dialogResult ?? false;
  }

  Future<void> showStopAccountDialog(
    String message,
    void Function() onPressed,
  ) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => onPressed(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
