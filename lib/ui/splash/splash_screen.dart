import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theshowplayer/blocs/common_blocs/authentication/authentication_bloc.dart';
import 'package:theshowplayer/configs/routers/router_name.dart';
import 'package:theshowplayer/constants/assets.dart';
import 'package:theshowplayer/di/action_method_locator.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state.when(
          initial: Splash.new,
          loading: Splash.new,
          fail: (_) => const SizedBox.shrink(),
          authenticated: (_, __, ___, ____) {
            Future.delayed(Duration.zero, () => navigation.navigatePushAndRemoveUntil(RouterName.dashboard));
            return const Splash();
          },
          unAuthenticated: (appNewInstall) {
            if (appNewInstall) {
              Future.delayed(Duration.zero, () => navigation.navigatePushAndRemoveUntil(RouterName.onboarding));
            } else {
              Future.delayed(Duration.zero, () => navigation.navigatePushAndRemoveUntil(RouterName.dashboard));
            }
            return const Splash();
          },
        );
      },
    );
  }
}

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(Assets.logoOnlyIcon)),
    );
  }
}
