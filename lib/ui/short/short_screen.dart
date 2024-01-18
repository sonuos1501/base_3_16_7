import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/short/short_screen_ipad.dart';
import 'package:theshowplayer/ui/short/short_screen_mobile.dart';
import 'package:theshowplayer/ui/short/short_sreen_desktop.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';
import 'package:video_player/video_player.dart';

import '../../models/channels/short_data.dart';

class ShortScreen extends StatelessWidget {
  const ShortScreen({
    super.key,
    required this.listShort,
    required this.index,
    this.videoPlayerController,
  });

  final List<ShortData> listShort;
  final int index;
  final void Function(VideoPlayerController videoPlayerController)? videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: ShortScreenMobile(
        listShort: listShort,
        index: index,
        videoPlayerController: (controller) {
          if (videoPlayerController != null) {
            videoPlayerController!(controller);
          }
        },
      ),
      ipads: const ShortScreenIpad(),
      desktops: const ShortScreenDesktop(),
    );
  }
}
