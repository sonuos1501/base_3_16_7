import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../di/action_method_locator.dart';
import '../dialog/dialog.dart';


class RequestPermission {
  RequestPermission._();

  static Future<bool> checkPermissionRequest({
    required Permission permission,
    required BuildContext context,
  }) async {
    final checkPermisstion = await permission.status;

    if (Platform.isAndroid && await permission.shouldShowRequestRationale) {
      return _openSettingPermission(permission);
    }

    if (checkPermisstion.isDenied) {
      return permission.request().isGranted;
    } else if (checkPermisstion.isPermanentlyDenied) {
      await _openSettingPermission(permission);
    }

    return true;
  }

  static Future<bool> _openSettingPermission(
    Permission permission,
  ) async {
    final result = await DialogUtils.showAlertDialog(
      context: navigation.context,
      title: 'Không được phép truy cập',
      content: 'Đi đến cài đặt',
      defaultActionText: 'Ok',
      cancelActionText: 'Huỷ',
    );

    if (result ?? false) {
      await openAppSettings();
    }
    return permission.isGranted;
  }
}
