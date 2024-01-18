part of 'signup_bloc.dart';


@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.choosedGender({ required String gender }) = ChoosedGender;
  const factory SignUpEvent.sawPassword({@Default(false) bool sawThePassword}) = SawPassword;
  const factory SignUpEvent.sawConfirmPassword({@Default(false) bool sawTheConfirmPassword}) = SawConfirmPassword;
  const factory SignUpEvent.pressedSignUp({required String userName,
    required String password,
    required String confirmPassword,
    required String email,
    String? gender,
  }) = PressedSignUp;
}
