import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'notifications_screen_desktop.dart';
import 'notifications_screen_ipad.dart';
import 'notifications_screen_mobile.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: NotificationsScreenMobile(),
      ipads: NotificationsScreenIpad(),
      desktops: NotificationsScreenDesktop(),
    );
  }
}
