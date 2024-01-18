import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'languages_settings_screen_desktop.dart';
import 'languages_settings_screen_ipad.dart';
import 'languages_settings_screen_mobile.dart';

class LanguagesSettingsScreen extends StatelessWidget {
  const LanguagesSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: LanguagesSettingsScreenMobile(),
      ipads: LanguagesSettingsScreenIpad(),
      desktops: LanguagesSettingsScreenDesktop(),
    );
  }
}
