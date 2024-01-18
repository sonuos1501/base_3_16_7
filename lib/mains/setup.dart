import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app.dart';
import '../blocs/common_blocs/authentication/authentication_bloc.dart';
import '../blocs/common_blocs/language/language_bloc.dart';
import '../blocs/common_blocs/theme/theme_bloc.dart';
import '../blocs/observer/bloc_observer.dart';
import '../configs/env/env_state.dart';
import '../di/service_locator.dart';

Future<void> setUpAndRunApp({
  required EnvState env,
}) async {
  await runZonedGuarded(
    () async {
      EnvValue.env = env;
      await _setPreferredOrientations();
      setupLocator(env: env);
      Bloc.observer = SimpleBlocDelegate();
      await _setUpNetwork();

      /// Init kakao sdk
      // KakaoSdk.init(
      //   nativeAppKey: '15bf71463e0a78663a5db0929f63d959',
      //   javaScriptAppKey: 'f6bc9be115f3f4328fd14cac35daf435',
      // );

      /// Init naver sdk
      // await FlutterNaverLogin.initSdk(
      //   clientId: 'HUkb8KPhpjDexm_JlzV9',
      //   clientName: 'The Show',
      //   clientSecret: 'GhnyI6HiBL',
      // );

      return runApp(
        DevicePreview(
          enabled: !kReleaseMode,
          builder: (context) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (contex) => sl<ThemeBloc>()),
                BlocProvider(create: (context) => sl<LanguageBloc>()),
                BlocProvider(
                  create: (context) => sl<AuthenticationBloc>()
                    ..add(const AuthenticationEvent.loadedApp()),
                ),
              ],
              child: App(env: env),
            );
          },
        ),
      );
    },
    (error, stack) {
      debugPrint(stack.toString());
      debugPrint(error.toString());
    },
    // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
}

Future<void> _setPreferredOrientations() {
  WidgetsFlutterBinding.ensureInitialized();
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

Future<void> _setUpNetwork() async {
  /// Hàm xử lý logout khi refesh token không thành công
  // GraphQLApiClient.actionNotRefeshToken = method();
  // HttpHelper.actionNotRefeshToken = method();

  /// Truyền finger nếu cần
  // GraphQLApiClient.finger = Mã finger;
  // HttpHelper.finger = Mã finger;

  /// Hàm get token đển network xử dụng
  // GraphQLApiClient.funcGetToken = () async => sl<Repository>().authToken();
  // HttpHelper.funcGetToken = () async => sl<Repository>().authToken();

  /// Hàm xử lý refesh token
  // GraphQLApiClient.refeshToken = method();
  // HttpHelper.refeshToken = method();
}
