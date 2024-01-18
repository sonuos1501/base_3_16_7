import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/ui/tabs/shorts/bloc/short_tab_bloc.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import '../../../di/service_locator.dart';
import 'shorts_tab_desktop.dart';
import 'shorts_tab_ipad.dart';
import 'shorts_tab_mobile.dart';

class ShortsTab extends StatelessWidget {
  const ShortsTab({ super.key, required this.channelId });

  final int channelId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ShortTabBloc>(),
      child: MultipleScreenUtil(
        mobiles: ShortsTabMobile(channelId: channelId),
        ipads: const ShortsTabIpad(),
        desktops: const ShortsTabDesktop(),
      ),
    );
  }
}
