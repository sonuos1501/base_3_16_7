
part of 'password_bloc.dart';

@freezed
class PasswordState with _$PasswordState {
  const factory PasswordState.initial() = PasswordInitialState;
  const factory PasswordState.fail({ String? errors }) = PasswordFailState;
  const factory PasswordState.loading() = PasswordLoadingState;
  const factory PasswordState.success({ String? message }) = PasswordSuccessState;
}
