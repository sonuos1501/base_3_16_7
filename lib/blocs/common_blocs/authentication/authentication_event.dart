// ignore_for_file: eol_at_end_of_file

part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.loadedApp() = LoadedApp;
  const factory AuthenticationEvent.loggedIn({
    required int userId,
    String? token,
    required LoginType loginType,
  }) = LoggedIn;
  const factory AuthenticationEvent.logout() = LoggedOut;
}

