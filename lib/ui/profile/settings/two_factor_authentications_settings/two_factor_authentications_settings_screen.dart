import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'two_factor_authentications_settings_screen_desktop.dart';
import 'two_factor_authentications_settings_screen_ipad.dart';
import 'two_factor_authentications_settings_screen_mobile.dart';

class TwoFactorAuthenticationsSettingsScreen extends StatelessWidget {
  const TwoFactorAuthenticationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: TwoFactorAuthenticationsSettingsScreenMobile(),
      ipads: TwoFactorAuthenticationsSettingsScreenIpad(),
      desktops: TwoFactorAuthenticationsSettingsScreenDesktop(),
    );
  }
}
