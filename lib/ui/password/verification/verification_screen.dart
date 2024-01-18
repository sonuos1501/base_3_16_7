
import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'verification_screen_desktop.dart';
import 'verification_screen_ipad.dart';
import 'verification_screen_mobile.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: VerificationScreenMobile(key: key),
      ipads: VerificationScreenIpad(key: key),
      desktops: VerificationScreenDesktop(key: key),
    );
  }
}
