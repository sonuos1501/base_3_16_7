import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'password_settings_screen_desktop.dart';
import 'password_settings_screen_ipad.dart';
import 'password_settings_screen_mobile.dart';

class PasswordSettingsScreen extends StatelessWidget {
  const PasswordSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: PasswordSettingsScreenMobile(),
      ipads: PasswordSettingsScreenIpad(),
      desktops: PasswordSettingsScreenDesktop(),
    );
  }
}
