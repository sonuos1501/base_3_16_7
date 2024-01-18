import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/channel/channel_screen_ipad.dart';
import 'package:theshowplayer/ui/channel/channel_screen_mobile.dart';
import 'package:theshowplayer/ui/channel/channel_sreen_desktop.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: ChannelScreenMobile(),
      ipads: ChannelScreenIpad(),
      desktops: ChannelScreenDesktop(),
    );
  }
}
