part of 'two_factor_authen_bloc.dart';

@freezed
class TwoFactorAuthenEvent with _$TwoFactorAuthenEvent {
  const factory TwoFactorAuthenEvent.turned({ @Default(false) bool turned }) = Turned;
}
