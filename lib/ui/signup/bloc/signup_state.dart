
part of 'signup_bloc.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial({ List<String>? listGender }) = SignUpInitialState;
  const factory SignUpState.loading() = SignUpLoadingState;
  const factory SignUpState.fail({ String? errors }) = SignUpFailState;
  const factory SignUpState.success({ required int userId, required String cookie }) = SignUpSuccessState;

  const factory SignUpState.gender({ required String gender }) = SignUpGenderState;
  const factory SignUpState.seePassword({@Default(false) bool seePassword}) = SignUpSeePWState;
  const factory SignUpState.seeConfirmPassword({@Default(false) bool seeConfirmPassword}) = SignUpSeeConfirmPWState;

}
