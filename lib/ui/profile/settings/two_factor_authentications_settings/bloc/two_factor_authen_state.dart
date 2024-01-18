part of 'two_factor_authen_bloc.dart';

@freezed
class TwoFactorAuthenState with _$TwoFactorAuthenState {
  const factory TwoFactorAuthenState.initial() = TwoFactorAuthenInitialState;

  const factory TwoFactorAuthenState.turnTwoFactorAuth({ @Default(false) bool turn }) = TwoFactorAuthenTurnState;
}
