import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/dimens.dart';

class LoadingWidget extends StatelessWidget {

  const LoadingWidget({super.key, this.color, this.size = 32,this.padding = 3, this.strokeWidth = 2});
  final Color? color;
  final double size,padding;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? Colors.brown),
      ),
    );
  }
}

class DialogUtils {
  static Future<bool?> showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    String? cancelActionText,
    required String defaultActionText,
  }) async {
    if (!Platform.isIOS) {
      return showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            if (cancelActionText != null)
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  cancelActionText,
                  // style: AppTextStyles.defaultRegular.copyWith(
                  //   color: AppColors.red2,
                  //   fontSize: 16,
                  // ),
                ),
              ),
            TextButton(
              child: Text(
                defaultActionText,
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
    }

    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(
                cancelActionText,
                // style: AppTextStyles.defaultMedium.copyWith(
                //   color: AppColors.red2,
                //   fontSize: 16,
                // ),
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
          CupertinoDialogAction(
            child: Text(defaultActionText),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  static Future<bool?> showActionSheet({
    required Widget acctionSheet,
    required BuildContext context,
  }) {
    return showCupertinoModalPopup<bool>(
      context: context,
      builder: (buildContext) => acctionSheet,
    );
  }


  static Future<void> showSimpleDialog(BuildContext context, String message) async {
    return await showDialog<void>(
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

  static Future<T?> buildBaseDialog<T>(
    BuildContext context, {
    Widget? header,
    Widget? body,
    List<Widget>? actions,
    bool? barrierDismissible,
    Color barrierColor = Colors.black54,
    double borderRadius = Dimens.dimens_16,
    double width = double.infinity,
    Color? backgroundColor,
    double elevation = 0,
    EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: Dimens.horizontal_padding),
  }) async {
    Dialog buildDialog() {
      return Dialog(
        insetPadding: insetPadding,
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.surfaceTint,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            width: width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  header != null
                    ? Padding(
                      padding: const EdgeInsets.only(top: Dimens.dimens_25, bottom: Dimens.dimens_20),
                      child: header!,
                    )
                    : const SizedBox(),
                  body ?? const SizedBox(),
                  actions == null ? const SizedBox() : Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: actions,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    final result = await showDialog(
      barrierDismissible: barrierDismissible ?? true,
      barrierColor: barrierColor,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return barrierDismissible ?? true;
          },
          child: buildDialog(),
        );
      },
    );

    return result;
  }

  static void showExitDialog(BuildContext context) {
    showDialog(
      barrierColor: const Color(0x01000000),
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
        });
        return Dialog(
          child: Container(
            width: 200,
            height: 30,
            decoration: const BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: const Center(
              child: Text(
                'Title',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        );
      },
    );
  }

}
