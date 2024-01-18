
part of 'password_bloc.dart';

@freezed
class PasswordEvent with _$PasswordEvent {
  const factory PasswordEvent.requestedNewPassword({ required String email }) = RequestedNewPassword;
}
