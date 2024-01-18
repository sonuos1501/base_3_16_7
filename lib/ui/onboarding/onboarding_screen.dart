import 'package:flutter/material.dart';
import 'package:theshowplayer/utils/screen/m_screen_util.dart';

import 'onboarding_screen_desktop.dart';
import 'onboarding_screen_ipad.dart';
import 'onboarding_screen_mobile.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MultipleScreenUtil(
      mobiles: OnboardingScreenMobile(),
      ipads: OnboardingScreenIpad(),
      desktops: OnboardingScreenDesktop(),
    );
  }
}
