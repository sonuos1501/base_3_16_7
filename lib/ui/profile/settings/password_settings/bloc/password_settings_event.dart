part of 'password_settings_bloc.dart';

@freezed
class PasswordSettingsEvent with _$PasswordSettingsEvent {
  const factory PasswordSettingsEvent.sawCurrentPassword({ @Default(false) bool sawCurrentPassword }) = SawCurrentPassword;
  const factory PasswordSettingsEvent.sawNewPassword({ @Default(false) bool sawNewPassword }) = SawNewPassword;
  const factory PasswordSettingsEvent.sawConfirmNewPassword({ @Default(false) bool sawConfirmNewPassword }) = SawConfirmNewPassword;

  const factory PasswordSettingsEvent.savedChangePassword({
    required String newPassword,
    required String confirmNewPassword,
    required String currentPassword,
  }) = SavedChangePassword;
}
