
import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';

import '../../../utils/custom_log/custom_log.dart';

part 'password_bloc.freezed.dart';
part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc(this._repository) : super(const PasswordState.initial()) {
    on<RequestedNewPassword>(_requestedNewPassword);
  }

  final Repository _repository;

  Future<void> _requestedNewPassword(RequestedNewPassword event, Emitter<PasswordState> emit) async {
    try {
      emit(const PasswordState.loading());

      final res = await _repository.resetPassword(email: event.email);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        return emit(PasswordState.success(message: res.data?.message ?? 'Successfull'));
      } else {
        emit(PasswordState.fail(errors: res.errors?.errorText ?? 'Error'));
      }
    } catch (e) {
      logError(e.toString());
      emit(PasswordState.fail(errors: e.toString()));
    }
  }
}
