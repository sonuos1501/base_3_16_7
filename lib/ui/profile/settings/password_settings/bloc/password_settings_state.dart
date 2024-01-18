part of 'password_settings_bloc.dart';

@freezed
class PasswordSettingsState with _$PasswordSettingsState {
  const factory PasswordSettingsState.initial() = PasswordSettingsInitialState;
  const factory PasswordSettingsState.loading() = PasswordSettingsLoadingState;
  const factory PasswordSettingsState.fail({ String? errors }) = PasswordSettingsFailState;
  const factory PasswordSettingsState.success({ String? message }) = PasswordSettingsSuccessState;

  const factory PasswordSettingsState.seeCurrentPassword({ @Default(false) bool seeCurrentPassword }) = PasswordSettingsSeeCurrentPasswordState;
  const factory PasswordSettingsState.seeNewPassword({ @Default(false) bool seeNewPassword }) = PasswordSettingsSeeNewPasswordState;
  const factory PasswordSettingsState.seeConfirmNewPassword({ @Default(false) bool seeConfirmNewPassword })
    = PasswordSettingsSeeConfirmNewPasswordState;
}
