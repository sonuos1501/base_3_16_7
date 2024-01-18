import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/watch/watch_screen_ipad.dart';
import 'package:theshowplayer/ui/watch/watch_screen_mobile.dart';
import 'package:theshowplayer/ui/watch/watch_sreen_desktop.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import '../../models/video_detail_model/video_detail_model.dart';

class WatchScreen extends StatelessWidget {
  const WatchScreen({ super.key, required this.video });

  final VideoDetailModel video;

  @override
  Widget build(BuildContext context) {
    return  MultipleScreenUtil(
      mobiles: WatchScreenMobile(video: video),
      ipads: const WatchScreenIpad(),
      desktops: const WatchScreenDesktop(),
    );
  }
}
