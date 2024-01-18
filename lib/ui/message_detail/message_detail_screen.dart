
import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/message_detail/message_detail_screen_desktop.dart';
import 'package:theshowplayer/ui/message_detail/message_detail_screen_ipad.dart';
import 'package:theshowplayer/ui/message_detail/message_detail_screen_mobile.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

class MessageDetailScreen extends StatelessWidget {
  const MessageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: MessageDetailScreenMobile(key: key),
      ipads: MessageDetailScreenIpad(key: key),
      desktops: MessageDetailScreenDesktop(key: key),
    );
  }
}
