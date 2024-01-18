// ignore_for_file: inference_failure_on_function_invocation
import 'package:flutter/material.dart';
import '../../di/action_method_locator.dart';
import '../../widgets/loading/loading_view.dart';

abstract class LoadingProcessBuilder {
  static bool _isShowingDialog = false;

  static void showProgressDialog() {
    _isShowingDialog = true;
    showDialog(
      context: navigation.context,
      barrierColor: Colors.transparent,
      barrierDismissible: false,
      builder: (_) {
        return WillPopScope(
          child: const LoadingView(),
          onWillPop: () async => false,
        );
      },
    ).then((value) {
      _isShowingDialog = false;
    });
  }

  /// need "await" when close
  static Future<void> closeProgressDialog() async {
    if (_isShowingDialog) {
      Navigator.of(navigation.context).pop();
    }
  }
}
