import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'settings_screen_desktop.dart';
import 'settings_screen_ipad.dart';
import 'settings_screen_mobile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: SettingsScreenMobile(),
      ipads: SettingsScreenIpad(),
      desktops: SettingsScreenDesktop(),
    );
  }
}
