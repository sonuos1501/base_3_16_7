// ignore_for_file: inference_failure_on_untyped_parameter, unnecessary_await_in_return, avoid_positional_boolean_parameters
import 'dart:async';
import '../blocs/common_blocs/authentication/authentication_bloc.dart';
import '../models/auth/login_data.dart';
import '../models/response/responses.dart';
import 'network/apis/auth/auth_api.dart';
import 'securestorage/secure_storage_helper.dart';
import 'sharedpref/shared_preference_helper.dart';

class Repository {
  /// constructor
  Repository({
    required AuthApi authApi,
    required SharedPreferenceHelper sharedPrefsHelper,
    required SecureStorageHelper secureStorageHelper,
  })  : _authApi = authApi,
        _sharedPrefsHelper = sharedPrefsHelper,
        _secureStorageHelper = secureStorageHelper;

  /// api objects
  final AuthApi _authApi;

  /// shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  /// secure storage object
  final SecureStorageHelper _secureStorageHelper;

  /// Authentiations:---------------------------------------------------------------------
  Future<Responses<LoginData>> loginByTraditional({
    required String userName,
    required String password,
  }) async {
    return await _authApi
        .loginByTraditional(userName: userName, password: password)
        .catchError((error) => throw error);
  }

  Future<LoginType> get loginType async => await _sharedPrefsHelper.loginType;

  Future<void> removeLoginType() async =>
      await _sharedPrefsHelper.removeLoginType();

  Future<void> saveLoginType(LoginType loginType) async =>
      await _sharedPrefsHelper.saveLoginType(loginType);

  /// Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark({required bool value}) =>
      _sharedPrefsHelper.changeBrightnessToDark(value: value);

  Future<bool> get isDarkMode async => await _sharedPrefsHelper.isDarkMode;

  /// Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  Future<String> get currentLanguage async =>
      await _sharedPrefsHelper.currentLanguage;

  /// Auth: ---------------------------------------------------------------------
  Future<String> get authToken async => await _secureStorageHelper.authToken;

  Future<void> saveAuthToken(String value) async =>
      await _secureStorageHelper.saveAuthToken(value);

  Future<void> removeAuthToken() async =>
      await _secureStorageHelper.removeAuthToken();

  /// User: ---------------------------------------------------------------------
  Future<void> saveUserId(int userId) async =>
      await _sharedPrefsHelper.saveUserId(userId);

  Future<int> get userId async => await _sharedPrefsHelper.userId;

  Future<void> removeUserId() async => await _sharedPrefsHelper.removeUserId();

  /// Check install application:------------------------------------------------------------------
  Future<bool> get appNewIntall async => await _sharedPrefsHelper.appNewIntall;

  Future<void> saveAppNewIntall(bool appNewIntall) async =>
      await _sharedPrefsHelper.saveAppNewIntall(appNewIntall);
}
