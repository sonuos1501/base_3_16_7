// ignore_for_file: unnecessary_await_in_return

import 'package:enum_to_string/enum_to_string.dart';
import '../../blocs/common_blocs/authentication/authentication_bloc.dart';
import '../../utils/shared_pref/PreferUtil.dart';
import 'constants/preferences.dart';
import 'shared_preference_helper.dart';

class SharedPreferenceHelperImpl implements SharedPreferenceHelper {
  @override
  Future<void> changeBrightnessToDark({required bool value}) async =>
      await PreferUtil.setBool(Preferences.is_dark_mode, value);

  @override
  Future<void> changeLanguage(String language) async =>
      await PreferUtil.setString(Preferences.current_language, language);

  @override
  Future<String> get currentLanguage async =>
      await PreferUtil.getString(Preferences.current_language);

  @override
  Future<bool> get isDarkMode async =>
      await PreferUtil.getBool(Preferences.is_dark_mode) ?? true;

  @override
  Future<void> saveUserId(int userId) async =>
      await PreferUtil.setInt(Preferences.user_id, userId);

  @override
  Future<int> get userId async =>
      await PreferUtil.getInt(Preferences.user_id) ?? -1;

  @override
  Future<void> removeUserId() async =>
      await PreferUtil.remove(Preferences.user_id);

  @override
  Future<LoginType> get loginType async =>
      EnumToString.fromString<LoginType>(
        LoginType.values,
        await PreferUtil.getString(Preferences.login_type),
      ) ??
      LoginType.traditional;

  @override
  Future<void> removeLoginType() async =>
      await PreferUtil.remove(Preferences.login_type);

  @override
  Future<void> saveLoginType(LoginType loginType) async =>
      await PreferUtil.setString(
        Preferences.login_type,
        EnumToString.convertToString(loginType),
      );

  @override
  Future<bool> get appNewIntall async =>
      await PreferUtil.getBool(Preferences.app_new_installed) ?? true;

  @override
  Future<void> saveAppNewIntall(bool appNewIntall) async =>
      await PreferUtil.setBool(Preferences.app_new_installed, appNewIntall);
}
