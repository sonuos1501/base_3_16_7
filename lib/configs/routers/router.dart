// ignore_for_file: only_throw_errors, strict_raw_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/service_locator.dart';
import '../../ui/login/bloc/login_bloc.dart';
import '../../ui/login/login_screen.dart';
import '../../ui/splash/splash_screen.dart';
import 'router_name.dart';

class Routes {
  const Routes._();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments ?? Object();
    switch (routeSettings.name) {
      case RouterName.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouterName.login:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<LoginBloc>(
            create: (_) => sl<LoginBloc>(),
            child: const LoginScreen(),
          ),
        );
      default:
        throw 'No page';
    }
  }
}
