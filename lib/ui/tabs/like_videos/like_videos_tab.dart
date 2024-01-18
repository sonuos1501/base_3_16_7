import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/ui/tabs/like_videos/bloc/like_video_tab_bloc.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import '../../../di/service_locator.dart';
import 'like_videos_tab_desktop.dart';
import 'like_videos_tab_ipad.dart';
import 'like_videos_tab_mobile.dart';

class LikeVideosTab extends StatelessWidget {
  const LikeVideosTab({super.key, required this.channelId});

  final int channelId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LikeVideoTabBloc>(
      create: (_) => sl<LikeVideoTabBloc>(),
      child: MultipleScreenUtil(
        mobiles: LikeVideosTabMobile(channelId: channelId),
        ipads: const LikeVideosTabIpad(),
        desktops: const LikeVideosTabDesktop(),
      ),
    );
  }
}
