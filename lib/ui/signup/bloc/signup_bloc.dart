
// ignore_for_file: invalid_use_of_visible_for_testing_member, inference_failure_on_instance_creation

import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/utils/custom_log/custom_log.dart';

part 'signup_bloc.freezed.dart';
part 'signup_event.dart';
part 'signup_state.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc(this._repository) : super(const SignUpState.initial()) {
    on<ChoosedGender>(_choosedGender);
    on<SawPassword>(_sawPassword);
    on<SawConfirmPassword>(_sawConfirmPassword);
    on<PressedSignUp>(_pressedSignUp);
    _init();
  }

  final _listGender = <String>['signup_mg4', 'signup_mg5'];

  final Repository _repository;

  Future<void> _init() async {
    emit(const SignUpState.loading());
    emit(SignUpState.initial(listGender: _listGender));
  }

  void _sawPassword(SawPassword event, Emitter<SignUpState> emit) {
    return emit(SignUpState.seePassword(seePassword: event.sawThePassword));
  }


  Future<void> _sawConfirmPassword(SawConfirmPassword event, Emitter<SignUpState> emit) async {
    return emit(SignUpState.seeConfirmPassword(seeConfirmPassword: event.sawTheConfirmPassword));
  }

  void _choosedGender(ChoosedGender event, Emitter<SignUpState> emit) {
    return emit(SignUpState.gender(gender: event.gender));
  }


  Future<void> _pressedSignUp(PressedSignUp event, Emitter<SignUpState> emit) async {
    try {
      emit(const SignUpState.loading());

      final res = await _repository.register(
        userName: event.userName,
        password: event.password,
        confirmPassword: event.confirmPassword,
        email: event.email,
        gender: event.gender,
      );

      if (res.apiStatus == HttpStatus.ok.toString()) {
        final cookie = res.data?.cookie ?? '';
        final userId = res.data?.userId ?? -1;

        if (cookie.isNotEmpty) {
          return emit(SignUpState.success(cookie: cookie, userId: userId));
        }

        emit(SignUpState.fail(errors: res.errors?.errorText ?? 'Error'));
      } else {
        emit(SignUpState.fail(errors: res.errors?.errorText ?? 'Error'));
      }

    } catch (e) {
      logError(e.toString());
      emit(SignUpState.fail(errors: e.toString()));
    }
  }
}
