// ignore_for_file: eol_at_end_of_file

part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState.initial() = AuthenticationInitial;
  const factory AuthenticationState.loading() = AuthenticationLoading;
  const factory AuthenticationState.fail({ String? errors }) = AuthenticationFail;

  const factory AuthenticationState.authenticated({
    required int userId,
    required String token,
    required LoginType loginType,
  }) = Authenticated;

  const factory AuthenticationState.unAuthenticated({ @Default(true) bool appNewIntall }) = UnAuthenticated;
}
