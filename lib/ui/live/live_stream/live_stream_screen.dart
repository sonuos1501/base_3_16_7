import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'live_stream_screen_desktop.dart';
import 'live_stream_screen_ipad.dart';
import 'live_stream_screen_mobile.dart';

class LiveStreamScreen extends StatelessWidget {
  const LiveStreamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: LiveStreamScreenMobile(),
      ipads: LiveStreamScreenIpad(),
      desktops: LiveStreamScreenDesktop(),
    );
  }
}
