
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/models/channels/argument_update_channel_info.dart';
import 'package:theshowplayer/widgets/ChooseImage/ChooseImage.dart';

import '../../../../constants/enum/gender.dart';
import '../../../../models/channels/channel_info_data.dart';
import '../../../../models/common/country_data.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';
part 'edit_profile_bloc.freezed.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(this._repository) : super(const EditProfileState.loading()) {
    on<_Loaded>(_loaded);
    on<ChoosedGender>(_choosedGender);
    on<ChoosedCountry>(_choosedCountry);
    on<Saved>(_saved);
  }

  final _listGender = <Gender>[Gender.male, Gender.female];

  final Repository _repository;

  Future<void> _loaded(_Loaded event, Emitter<EditProfileState> emit) async {
    emit(const EditProfileState.loading());
    final countries = await getAllCountry();
    emit(EditProfileState.initial(
      listGenders: _listGender,
      countries: countries,
    ),);
  }

  Future<void> _choosedGender(ChoosedGender event, Emitter<EditProfileState> emit) async {
    return emit(EditProfileState.gender(gender: event.gender));
  }

  Future<void> _choosedCountry(ChoosedCountry event, Emitter<EditProfileState> emit) async {
    return emit(EditProfileState.country(country: event.country));
  }

  Future<List<Country>> getAllCountry() async {
    try {
      final res = await _repository.getAllCountry(accessToken: await _repository.authToken);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return res.data?.countries ?? [];
      }

    } catch (_) {}

    return [];
  }

  Future<void> _saved(Saved event, Emitter<EditProfileState> emit) async {
    try {
      emit(const EditProfileState.loading());

      final res = await _repository.updateChannelInfo(
        accessToken: await _repository.authToken,
        argumentUpdateChannelInfo: event.argumentUpdateChannelInfo,
      );
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        emit(EditProfileState.success(message: res.message));
      } else {
        emit(EditProfileState.fail(errors: res.errors?.errorText));
      }

    } catch (e) {
      emit(EditProfileState.fail(errors: e.toString()));
    }
  }

}
