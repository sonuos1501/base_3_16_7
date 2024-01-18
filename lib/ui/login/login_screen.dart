
import 'package:flutter/material.dart';

import '../../utils/screen/m_screen_util.dart';
import 'login_screen_desktop.dart';
import 'login_screen_ipad.dart';
import 'login_screen_mobile.dart';


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
