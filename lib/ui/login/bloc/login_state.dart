part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitialState;
  const factory LoginState.loading() = LoginLoadingState;
  const factory LoginState.fail({ String? errors }) = LoginFailState;
  const factory LoginState.success({ String? message }) = LoginSuccessState;

  const factory LoginState.seePassword({@Default(false) bool seePassword}) = LoginSeePWState;
}
