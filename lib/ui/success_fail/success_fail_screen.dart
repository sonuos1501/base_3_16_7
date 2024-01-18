// ignore_for_file: avoid_multiple_declarations_per_line

import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'success_fail_screen_desktop.dart';
import 'success_fail_screen_ipad.dart';
import 'success_fail_screen_mobile.dart';

class SuccessFailScreen extends StatelessWidget {
  const SuccessFailScreen({
    super.key,
    required this.imageBackground,
    required this.titleNoti,
    required this.contentNoti,
    this.actions,
  });

  final String imageBackground;
  final String titleNoti, contentNoti;
  final Widget? actions;

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: SuccessFailScreenMobile(
        key: key,
        imageBackground: imageBackground,
        titleNoti: titleNoti,
        contentNoti: contentNoti,
        actions: actions,
      ),
      ipads: SuccessFailScreenIpad(
        key: key,
        imageBackground: imageBackground,
        titleNoti: titleNoti,
        contentNoti: contentNoti,
        actions: actions,
      ),
      desktops: SuccessFailScreenDesktop(
        key: key,
        imageBackground: imageBackground,
        titleNoti: titleNoti,
        contentNoti: contentNoti,
        actions: actions,
      ),
    );
  }
}
