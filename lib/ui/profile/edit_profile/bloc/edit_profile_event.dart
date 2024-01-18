part of 'edit_profile_bloc.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  const factory EditProfileEvent.loaded() = _Loaded;

  const factory EditProfileEvent.choosedGender({ Gender? gender }) = ChoosedGender;
  const factory EditProfileEvent.choosedCountry({ Country? country }) = ChoosedCountry;
  const factory EditProfileEvent.saved({ required ArgumentUpdateChannelInfo argumentUpdateChannelInfo }) = Saved;
}
