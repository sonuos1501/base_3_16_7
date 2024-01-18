
import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'resetpassword_screen_desktop.dart';
import 'resetpassword_screen_ipad.dart';
import 'resetpassword_screen_mobile.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: ResetPasswordScreenMobile(key: key),
      ipads: ResetPasswordScreenIpad(key: key),
      desktops: ResetPasswordScreenDesktop(key: key),
    );
  }
}
