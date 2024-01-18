
import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/join_us/joinus_screen_mobile.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'joinus_screen_desktop.dart';
import 'joinus_screen_ipad.dart';

class JoinUsScreen extends StatelessWidget {
  const JoinUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: JoinUsScreenMobile(key: key),
      ipads: JoinUsScreenIpad(key: key),
      desktops: JoinUsScreenDesktop(key: key),
    );
  }
}
