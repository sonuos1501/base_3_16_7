part of 'edit_profile_bloc.dart';

@freezed
class EditProfileState with _$EditProfileState {
  const factory EditProfileState.initial({
    List<Gender>? listGenders,
    List<Country>? countries,
  }) = EditProfileInitialState;
  const factory EditProfileState.loading() = EditProfileLoadingState;
  const factory EditProfileState.fail({ String? errors }) = EditProfileFailState;
  const factory EditProfileState.success({ String? message }) = EditProfileSuccessState;

  const factory EditProfileState.gender({ Gender? gender }) = EditProfileGenderState;
  const factory EditProfileState.country({Country? country }) = EditProfileCountryState;

}
