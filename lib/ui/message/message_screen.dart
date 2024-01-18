
import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/message/message_screen_desktop.dart';
import 'package:theshowplayer/ui/message/message_screen_ipad.dart';
import 'package:theshowplayer/ui/message/message_screen_mobile.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultipleScreenUtil(
      mobiles: MessageScreenMobile(key: key),
      ipads: MessageScreenIpad(key: key),
      desktops: MessageScreenDesktop(key: key),
    );
  }
}
