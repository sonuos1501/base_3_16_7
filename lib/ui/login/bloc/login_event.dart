part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.logedInTraditional({
    required String username,
    required String password,
  }) = LogedInTraditional;


  const factory LoginEvent.sawPassword({@Default(false) bool sawThePassword}) = SawPassword;
}
