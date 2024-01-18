import 'package:flutter/material.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/ui/onboarding/bloc/onboarding_bloc.dart';
import 'package:theshowplayer/ui/onboarding/widgets/onboarding_page.dart';

import '../../constants/assets.dart';
import '../../di/service_locator.dart';


class OnboardingScreenMobile extends StatefulWidget {
  const OnboardingScreenMobile({super.key});

  @override
  State<OnboardingScreenMobile> createState() => _OnboardingScreenMobileState();
}

class _OnboardingScreenMobileState extends State<OnboardingScreenMobile> {
  final _pageController = PageController();

  final _pages = <ParamsOnboardingPage>[
    ParamsOnboardingPage(background: Assets.onboarding1, title: 'onboarding_mg0', content: 'onboarding_mg2'),
    ParamsOnboardingPage(background: Assets.onboarding2, title: 'onboarding_mg1', content: 'onboarding_mg3'),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages.map((e) {
          return OnboardingPage(
            paramsOnboardingPage: e,
            onPress: () async {
              if (_pageController.page == _pages.length - 1) {
                sl<OnboardingBloc>().add(const OnboardingEvent.donedIntruduction());
                await navigation.navigatePushAndRemoveUntil(RouterName.dashboard);
                return;
              }

              await _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.bounceInOut);
            },
          );
        }).toList(),
      ),
    );
  }
}
