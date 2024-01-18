import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'block_users_screen_desktop.dart';
import 'block_users_screen_ipad.dart';
import 'block_users_screen_mobile.dart';

class BlockUsersScreen extends StatelessWidget {
  const BlockUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: BlockUsersScreenMobile(),
      ipads: BlockUsersScreenIpad(),
      desktops: BlockUsersScreenDesktop(),
    );
  }
}
