// ignore_for_file: avoid_dynamic_calls, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:theshowplayer/data/repository.dart';
import 'package:theshowplayer/utils/custom_log/custom_log.dart';

import '../../../blocs/common_blocs/authentication/authentication_bloc.dart';
import '../../../constants/enum/social.dart';



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
  : _authenticationBloc = authenticationBloc, super(const LoginState.initial()) {
    on<LogedInTraditional>(
      _logedInTraditional,
      transformer: debounce(const Duration(milliseconds: 300)),
    );
    on<LogedInWithKakao>(_logedinWithKakao);
    on<LogedInWithNaver>(_logedinWithNaver);
    on<LogedInWithGoogle>(_logedInWithGoogle);
    on<SawPassword>(_sawPassword);
    googleSignIn = GoogleSignIn();
    _init();
  }

  void _init() {
    add(const LoginEvent.sawPassword(sawThePassword: true));
  }

  final Repository _repository;

  final AuthenticationBloc _authenticationBloc;
  late GoogleSignIn googleSignIn;

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

      final res = await _repository.loginByTraditional(userName: event.username, password: event.password);
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

          return emit(LoginState.success(message: res.data?.message ?? 'Successfull'));
        }

        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      } else {
        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      }
    } catch (error) {
      emit(LoginState.fail(errors: error.toString()));
    }
  }

  Future<void> _logedInWithGoogle(LogedInWithGoogle event, Emitter<LoginState> emit) async {
    try {
      final googleSignInAccount = await googleSignIn.signIn();

      final googleAuth = await googleSignInAccount!.authentication;

      logSuccess(googleAuth.accessToken);
      logSuccess(googleAuth.idToken);

      emit(const LoginState.loading());

      final res = await _repository.loginBySocial(accessToken: googleAuth.idToken ?? '', social: Social.google);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        final cookie = res.data?.cookie;
        final userId = res.data?.userId;

        if ((cookie ?? '').isNotEmpty) {
          _authenticationBloc.add(
            AuthenticationEvent.loggedIn(
              userId: userId ?? -1,
              token: cookie,
              loginType: LoginType.google,
            ),
          );

          return emit(LoginState.success(message: res.data?.message ?? 'Successfull'));
        }

        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      } else {
        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      }

    } catch (e) {
      logError(e.toString());
      emit(LoginState.fail(errors: e.toString()));
    }
  }

  Future<void> _logedinWithNaver(
    LogedInWithNaver event,
    Emitter<LoginState> emit,
  ) async {
    try {
      await FlutterNaverLogin.logIn();

      final accessToken = await FlutterNaverLogin.currentAccessToken;

      logSuccess(accessToken);

      emit(const LoginState.loading());

      final res = await _repository.loginBySocial(accessToken: accessToken.accessToken, social: Social.naver);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        final cookie = res.data?.cookie;
        final userId = res.data?.userId;

        if ((cookie ?? '').isNotEmpty) {
          _authenticationBloc.add(
            AuthenticationEvent.loggedIn(
              userId: userId ?? -1,
              token: cookie,
              loginType: LoginType.naver,
            ),
          );

          return emit(LoginState.success(message: res.data?.message ?? 'Successfull'));
        }

        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      } else {
        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      }

    } catch (e) {
      logError(e.toString());
      emit(LoginState.fail(errors: e.toString()));
    }
  }

  Future<void> _logedinWithKakao(
    LogedInWithKakao event,
    Emitter<LoginState> emit,
  ) async {
    try {
      final talkInstalled = await isKakaoTalkInstalled();

      // If Kakao Talk has been installed, log in with Kakao Talk. Otherwise, log in with Kakao Account.
      final token = talkInstalled
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();
      logSuccess('Login succeeds. ${token.accessToken}');

      emit(const LoginState.loading());

      final res = await _repository.loginBySocial(accessToken: token.accessToken, social: Social.kakao);
      final status = res.apiStatus ?? '';

      if (status == HttpStatus.ok.toString()) {
        final cookie = res.data?.cookie;
        final userId = res.data?.userId;

        if ((cookie ?? '').isNotEmpty) {
          _authenticationBloc.add(
            AuthenticationEvent.loggedIn(
              userId: userId ?? -1,
              token: cookie,
              loginType: LoginType.kakao,
            ),
          );

          return emit(LoginState.success(message: res.data?.message ?? 'Successfull'));
        }

        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      } else {
        emit(LoginState.fail(errors: res.errors?.errorText ?? 'Error'));
      }

    } catch (e) {
      logError(e.toString());
      emit(LoginState.fail(errors: e.toString()));
    }
  }

}
