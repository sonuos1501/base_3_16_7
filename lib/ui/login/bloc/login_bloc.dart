// ignore_for_file: avoid_dynamic_calls, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../blocs/common_blocs/authentication/authentication_bloc.dart';
import '../../../data/repository.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

// const throttleDuration = Duration(milliseconds: 100);

// EventTransformer<E> throttleDroppable<E>(Duration duration) {
//   return (events, mapper) {
//     return droppable<E>().call(events.throttle(duration), mapper);
//   };
// }

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._repository, {required AuthenticationBloc authenticationBloc})
      : _authenticationBloc = authenticationBloc,
        super(const LoginState.initial()) {
    on<LogedInTraditional>(
      _logedInTraditional,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<SawPassword>(_sawPassword);
    _init();
  }

  void _init() {
    add(const LoginEvent.sawPassword(sawThePassword: true));
  }

  final Repository _repository;

  final AuthenticationBloc _authenticationBloc;

  //ex: debounce from rx dart
  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  void _sawPassword(SawPassword event, Emitter<LoginState> emit) {
    emit(LoginState.seePassword(seePassword: event.sawThePassword));
    return;
  }

  Future<void> _logedInTraditional(
    LogedInTraditional event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(const LoginState.loading());

      final res = await _repository.loginByTraditional(
        userName: event.username,
        password: event.password,
      );
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        final cookie = res.data?.cookie;
        final userId = res.data?.userId;

        if ((cookie ?? '').isNotEmpty) {
          _authenticationBloc.add(
            LoggedIn(
              userId: userId ?? -1,
              token: cookie,
              loginType: LoginType.traditional,
            ),
          );

          return emit(
            LoginState.success(message: res.data?.message ?? 'Successfull'),
          );
        }

        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      } else {
        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      }
    } catch (error) {
      emit(LoginState.fail(errors: error.toString()));
    }
  }
}
