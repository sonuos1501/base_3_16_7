import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'history_screen_desktop.dart';
import 'history_screen_ipad.dart';
import 'history_screen_mobile.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: HistoryScreenMobile(),
      ipads: HistoryScreenIpad(),
      desktops: HistoryScreenDesktop(),
    );
  }
}
