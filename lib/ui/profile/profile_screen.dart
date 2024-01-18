
import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'profile_screen_desktop.dart';
import 'profile_screen_ipad.dart';
import 'profile_screen_mobile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: ProfileScreenMobile(key: key),
      ipads: ProfileScreenIpad(key: key),
      desktops: ProfileScreenDesktop(key: key),
    );
  }
}
