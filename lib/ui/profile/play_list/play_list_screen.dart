import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'play_list_screen_desktop.dart';
import 'play_list_screen_ipad.dart';
import 'play_list_screen_mobile.dart';

class PlayListScreen extends StatelessWidget {
  const PlayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: PlayListScreenMobile(),
      ipads: PlayListScreenIpad(),
      desktops: PlayListScreenDesktop(),
    );
  }
}
