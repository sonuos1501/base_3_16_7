import 'package:flutter/material.dart';
import 'package:theshowplayer/ui/premium/premium_screen_ipad.dart';
import 'package:theshowplayer/ui/premium/premium_screen_mobile.dart';
import 'package:theshowplayer/ui/premium/premium_sreen_desktop.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: PremiumScreenMobile(),
      ipads: PremiumScreenIpad(),
      desktops: PremiumScreenDesktop(),
    );
  }
}
