import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'edit_profile_screen_desktop.dart';
import 'edit_profile_screen_ipad.dart';
import 'edit_profile_screen_mobile.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: EditProfileScreenMobile(),
      ipads: EditProfileScreenIpad(),
      desktops: EditProfileScreenDesktop(),
    );
  }
}
