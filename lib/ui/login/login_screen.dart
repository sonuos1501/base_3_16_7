
import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/login/login_screen_desktop.dart';
import 'package:theshowplayer/ui/login/login_screen_ipad.dart';
import 'package:theshowplayer/ui/login/login_screen_mobile.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: LoginScreenMobile(key: key),
      ipads: LoginScreenIpad(key: key),
      desktops: LoginScreenDesktop(key: key),
    );
  }
}
