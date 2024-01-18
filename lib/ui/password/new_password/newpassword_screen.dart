
import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'newpassword_screen_desktop.dart';
import 'newpassword_screen_ipad.dart';
import 'newpassword_screen_mobile.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: NewPasswordScreenMobile(key: key),
      ipads: NewPasswordScreenIpad(key: key),
      desktops: NewPasswordScreenDesktop(key: key),
    );
  }
}
