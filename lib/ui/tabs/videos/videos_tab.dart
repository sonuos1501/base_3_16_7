import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/di/service_locator.dart';
import 'package:theshowplayer/ui/tabs/videos/bloc/video_tab_bloc.dart';

import '../../../utils/screen/m_screen_util.dart';
import 'videos_tab_desktop.dart';
import 'videos_tab_ipad.dart';
import 'videos_tab_mobile.dart';

class VideosTab extends StatelessWidget {
  const VideosTab({ super.key, required this.channelId });

  final int channelId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<VideoTabBloc>(),
      child: MultipleScreenUtil(
        mobiles: VideosTabMobile(channelId: channelId),
        ipads: const VideosTabIpad(),
        desktops: const VideosTabDesktop(),
      ),
    );
  }
}
