//
// ignore_for_file: type_annotate_public_apis, always_declare_return_types, strict_raw_type

import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

/// Helper class for device related operations.
///
class DeviceUtils {

  // ignore: inference_failure_on_function_return_type
  ///
  /// hides the keyboard if its already open
  ///
  static hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// orientation
  ///
  static double getScaledSize(BuildContext context, double scale) =>
      scale *
          (MediaQuery.of(context).orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height);

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// width
  ///
  static double getScaledWidth(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.width;

  ///
  /// accepts a double [scale] and returns scaled sized based on the screen
  /// height
  ///
  static double getScaledHeight(BuildContext context, double scale) =>
      scale * MediaQuery.of(context).size.height;

  static String? deviceName;
  static String? deviceVersion;
  static String? deviceId;//duy nhất khi cài app

  static Future initData() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceName = '${androidInfo.brand}_${androidInfo.model}';
      deviceVersion = androidInfo.version.release;
    }
    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
      deviceVersion = iosInfo.systemVersion;
    }
    deviceId = await Utils.getDeviceIdentifier();
  }
}
