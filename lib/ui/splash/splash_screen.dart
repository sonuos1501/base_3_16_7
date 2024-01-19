import 'package:base_3_16_7/utils/custom_log/custom_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info/package_info.dart';
import '../../blocs/common_blocs/authentication/authentication_bloc.dart';
import '../../gen/assets.gen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final packageInfo = await PackageInfo.fromPlatform();

      final appName = packageInfo.appName;
      final packageName = packageInfo.packageName;

      logSuccess('APP Name: $appName');
      logSuccess('Package Name: $packageName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return state.when(
          initial: Splash.new,
          loading: Splash.new,
          fail: (_) => const SizedBox.shrink(),
          authenticated: (_, __, ___) {
            // Future.delayed(
            //     Duration.zero,
            //     () => navigation
            //         .navigatePushAndRemoveUntil(RouterName.dashboard));
            return const Splash();
          },
          unAuthenticated: (appNewInstall) {
            if (appNewInstall) {
              // Future.delayed(
              //     Duration.zero,
              //     () => navigation
              //         .navigatePushAndRemoveUntil(RouterName.onboarding));
            } else {
              // Future.delayed(
              //     Duration.zero,
              //     () => navigation
              //         .navigatePushAndRemoveUntil(RouterName.dashboard));
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
      body: Center(child: Assets.logo.logoOnlyIcon.image()),
    );
  }
}
