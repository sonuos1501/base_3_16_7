import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'delete_account_screen_desktop.dart';
import 'delete_account_screen_ipad.dart';
import 'delete_account_screen_mobile.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: DeleteAccountScreenMobile(),
      ipads: DeleteAccountScreenIpad(),
      desktops: DeleteAccountScreenDesktop(),
    );
  }
}
