// ignore_for_file: unnecessary_await_in_return, avoid_positional_boolean_parameters
import 'dart:async';

import '../../blocs/common_blocs/authentication/authentication_bloc.dart';

mixin SharedPreferenceHelper {

  /// Theme:---------------------------------------------------------------------
  Future<bool> get isDarkMode;

  Future<void> changeBrightnessToDark({required bool value});

  /// Language:------------------------------------------------------------------
  Future<String> get currentLanguage;

  Future<void> changeLanguage(String language);

  /// User:------------------------------------------------------------------
  Future<int> get userId;

  Future<void> saveUserId(int userId);

  Future<void> removeUserId();

  /// Login:------------------------------------------------------------------
  Future<LoginType> get loginType;

  Future<void> saveLoginType(LoginType loginType);

  Future<void> removeLoginType();

  /// Check new install application:------------------------------------------------------------------
  Future<bool> get appNewIntall;

  Future<void> saveAppNewIntall(bool appNewIntall);

}
