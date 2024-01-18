

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'blocs/common_blocs/language/language_bloc.dart';
import 'blocs/common_blocs/theme/theme_bloc.dart';
import 'configs/env/env_state.dart';
import 'configs/routers/router.dart';
import 'constants/app_theme.dart';
import 'constants/strings.dart';
import 'di/action_method_locator.dart';
import 'utils/locale/app_localization.dart';
import 'utils/utils.dart';
import 'widgets/button/common_button.dart';

class App extends StatelessWidget {
  const App({super.key, required this.env});

  final EnvState env;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: CommonButton(
        onPress: () async {
          Utils.onHideKeyboard(context);
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, theme) {
            return BlocBuilder<LanguageBloc, LanguageState>(
              builder: (context, lang) {
                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: theme.isDarkMode
                    ? SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent)
                    : SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
                  child: MaterialApp(
                    debugShowCheckedModeBanner: env == EnvValue.development,
                    title: Strings.appName,
                    theme: theme.isDarkMode ? AppThemeData.darkThemeData : AppThemeData.lightThemeData,
                    navigatorKey: navigation.navigatorKey,
                    locale: Locale(lang.language.locale ?? 'en'),
                    supportedLocales: supportedLanguages
                      .map((language) => Locale(language.locale!, language.code))
                      .toList(),
                    localizationsDelegates: const [
                      // A class which loads the translations from JSON files
                      AppLocalizations.delegate,
                      // Built-in localization of basic text for Material widgets
                      GlobalMaterialLocalizations.delegate,
                      // Built-in localization for text direction LTR/RTL
                      GlobalWidgetsLocalizations.delegate,
                      // Built-in localization of basic text for Cupertino widgets
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    onGenerateRoute: Routes.onGenerateRoute,
                    builder: (context, child) {
                      ScreenUtil.init(context);
                      return child ?? const SizedBox();
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
