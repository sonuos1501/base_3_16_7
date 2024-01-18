
import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'signup_screen_desktop.dart';
import 'signup_screen_ipad.dart';
import 'signup_screen_mobile.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: SignUpScreenMobile(key: key),
      ipads: SignUpScreenIpad(key: key),
      desktops: SignUpScreenDesktop(key: key),
    );
  }
}
