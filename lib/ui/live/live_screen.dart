import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/live/live_screen_ipad.dart';
import 'package:theshowplayer/ui/live/live_screen_mobile.dart';
import 'package:theshowplayer/ui/live/live_sreen_desktop.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: LiveScreenMobile(),
      ipads: LiveScreenIpad(),
      desktops: LiveScreenDesktop(),
    );
  }
}
