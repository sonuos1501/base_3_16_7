import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/ui/tabs/playlist/bloc/playlist_tab_bloc.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import '../../../di/service_locator.dart';
import 'playlist_tab_desktop.dart';
import 'playlist_tab_ipad.dart';
import 'playlist_tab_mobile.dart';


class PlaylistTab extends StatelessWidget {
  const PlaylistTab({ super.key, required this.channelId });

    final int channelId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PlaylistTabBloc>(),
      child: MultipleScreenUtil(
        mobiles: PlaylistTabMobile(channelId: channelId),
        ipads: const PlaylistTabIpad(),
        desktops: const PlaylistTabDesktop(),
      ),
    );
  }
}
