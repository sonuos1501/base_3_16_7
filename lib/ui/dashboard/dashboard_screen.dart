// ignore_for_file: use_build_context_synchronously, avoid_catches_without_on_clauses

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:theshowplayer/ui/dashboard/dashboard_screen_desktop.dart';
import 'package:theshowplayer/ui/dashboard/dashboard_screen_ipad.dart';
import 'package:theshowplayer/ui/dashboard/dashboard_screen_mobile.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';
import 'package:theshowplayer/utils/update/flutter_check_version_app.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _checkVersion();
    });
  }

  Future<void> _checkVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final packageName = packageInfo.packageName;
    log(packageName);
    final checkVersion = FlutterCheckVersionApp(
      packageName: packageName,
      country: 'kr',
    );
    try {
      await checkVersion.checkVersion(context);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: DashBoardScreenMobile(key: widget.key),
      ipads: DashBoardScreenIpad(key: widget.key),
      desktops: DashBoardScreenDesktop(key: widget.key),
    );
  }
}
