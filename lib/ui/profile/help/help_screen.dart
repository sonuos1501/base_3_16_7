import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'help_screen_desktop.dart';
import 'help_screen_ipad.dart';
import 'help_screen_mobile.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: HelpScreenMobile(),
      ipads: HelpScreenIpad(),
      desktops: HelpScreenDesktop(),
    );
  }
}
