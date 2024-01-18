import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'rented_videos_screen_desktop.dart';
import 'rented_videos_screen_ipad.dart';
import 'rented_videos_screen_mobile.dart';

class RentedVideosScreen extends StatelessWidget {
  const RentedVideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: RentedVideosScreenMobile(),
      ipads: RentedVideosScreenIpad(),
      desktops: RentedVideosScreenDesktop(),
    );
  }
}
