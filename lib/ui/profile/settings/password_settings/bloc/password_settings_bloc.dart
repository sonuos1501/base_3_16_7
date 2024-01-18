import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/utils/custom_log/custom_log.dart';

part 'password_settings_event.dart';
part 'password_settings_state.dart';
part 'password_settings_bloc.freezed.dart';

class PasswordSettingsBloc extends Bloc<PasswordSettingsEvent, PasswordSettingsState> {
  PasswordSettingsBloc(this._repository) : super(const PasswordSettingsState.initial()) {
    on<SawCurrentPassword>(_sawCurrentPassword);
    on<SawNewPassword>(_sawNewPassword);
    on<SawConfirmNewPassword>(_sawConfirmNewPassword);
    on<SavedChangePassword>(_savedChangePassword);
  }

  final Repository _repository;

  Future<void> _sawCurrentPassword(SawCurrentPassword event, Emitter<PasswordSettingsState> emit) async {
    return emit(PasswordSettingsState.seeCurrentPassword(seeCurrentPassword: event.sawCurrentPassword));
  }

  Future<void> _sawNewPassword(SawNewPassword event, Emitter<PasswordSettingsState> emit) async {
    return emit(PasswordSettingsState.seeNewPassword(seeNewPassword: event.sawNewPassword));
  }

  Future<void> _sawConfirmNewPassword(SawConfirmNewPassword event, Emitter<PasswordSettingsState> emit) async {
    return emit(PasswordSettingsState.seeConfirmNewPassword(seeConfirmNewPassword: event.sawConfirmNewPassword));
  }

  Future<void> _savedChangePassword(SavedChangePassword event, Emitter<PasswordSettingsState> emit) async {
    try {
      emit(const PasswordSettingsState.loading());

      final res = await _repository.changePassword(
        newPassword: event.newPassword,
        confirmNewPassword: event.confirmNewPassword,
        currentPassword: event.currentPassword,
        accessToken: await _repository.authToken,
      );
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(PasswordSettingsState.success(message: res.message));
      } else {
        emit(PasswordSettingsState.fail(errors: res.errors?.errorText));
      }

    } catch (e) {
      logError(e.toString());
      emit(PasswordSettingsState.fail(errors: e.toString()));
    }
  }
}
