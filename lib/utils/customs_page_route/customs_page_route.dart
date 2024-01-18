// ignore_for_file: strict_raw_type

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class CustomMaterialPageRoute extends MaterialPageRoute {

  CustomMaterialPageRoute({
    this.willPopScopeCallBack,
    required super.builder,
    super.settings,
    super.maintainState,
    super.fullscreenDialog,
  });

  final AsyncCallback? willPopScopeCallBack;

  @override
  @protected
  bool get hasScopedWillPopCallback {
    if (willPopScopeCallBack != null) {
      willPopScopeCallBack!();
    }
    return true;
  }
}
