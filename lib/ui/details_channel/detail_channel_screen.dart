import 'package:flutter/material.dart';
import 'package:theshowplayer/models/channels/response_get_top_channels.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'detail_channel_screen_desktop.dart';
import 'details_channel_screen_ipad.dart';
import 'details_channel_screen_mobile.dart';

class ArgumentsOfDetailChannelScreen {
  const ArgumentsOfDetailChannelScreen({ required this.channels });

  final Channels channels;
}

class DetailChannelScreen extends StatelessWidget {
  const DetailChannelScreen({ super.key, required this.argumentsOfDetailChannelScreen });

  final ArgumentsOfDetailChannelScreen argumentsOfDetailChannelScreen;

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: DetailChannelScreenMobile(argumentsOfDetailChannelScreen: argumentsOfDetailChannelScreen),
      ipads: const DetailChannelScreenIpad(),
      desktops: const DetailChannelScreenDesktop(),
    );
  }
}
