// ignore_for_file: file_names, inference_failure_on_function_invocation

import 'package:flutter/material.dart';

abstract class BottomSheetUtil {
  static Future<T?> buildBaseButtonSheet<T>(
    BuildContext context, {
    required Widget child,
    bool isScroll = true,
    Color? color,
  }) async {
    final res = await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: isScroll,
      backgroundColor: color,
      builder: (c) => child,
    );
    return res;
  }

  static Future<T?> buildRatioButtonSheet<T>(
    BuildContext context, {
    required Widget child,
    double ratio = 0.9,
    bool isScroll = true,
    Color? color,
  }) async {
    final res = await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: isScroll,
      backgroundColor: color,
      builder: (c) => SizedBox(
        height: MediaQuery.of(context).size.height * ratio,
        width: double.infinity,
        child: child,
      ),
    );
    return res;
  }
}
