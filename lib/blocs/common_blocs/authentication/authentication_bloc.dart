import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/repository.dart';
part 'authentication_bloc.freezed.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

enum LoginType { google, kakao, naver, traditional }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._repository) : super(const AuthenticationInitial()) {
    on<LoadedApp>(_loadedApp);
    on<LoggedOut>(_logout);
  }

  final Repository _repository;

  Future<void> _loadedApp(
    LoadedApp event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationLoading());

    final token = await _repository.authToken;
    final userId = await _repository.userId;
    final loginType = await _repository.loginType;

    if (token.isNotEmpty) {
      return emit(
        AuthenticationState.authenticated(
          userId: userId,
          token: token,
          loginType: loginType,
        ),
      );
    }

    emit(
      AuthenticationState.unAuthenticated(
        appNewIntall: await _repository.appNewIntall,
      ),
    );
  }

  Future<void> _logout(
    LoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (state is Authenticated) {
      final state = this.state as Authenticated;

      // try {
      // emit(const AuthenticationState.loading());

      // final res = await _repository.logout(userId: await _repository.userId, session: await _repository.authToken);
      // final status = res.apiStatus ?? '';

      // if (status == HttpStatus.ok.toString()) {
      //   // if (state.loginType == LoginType.kakao) {
      //   //   await UserApi.instance.logout();
      //   //   await UserApi.instance.unlink();
      //   // } else if (state.loginType == LoginType.naver) {
      //   //   await FlutterNaverLogin.logOutAndDeleteToken();
      //   // } else if (state.loginType == LoginType.google) {
      //   //   await sl.get<LoginBloc>().googleSignIn.signOut();
      //   // }

      //   await _repository.removeAuthToken();
      //   await _repository.removeUserId();
      //   await _repository.removeLoginType();

      //     emit(AuthenticationState.unAuthenticated(appNewIntall: await _repository.appNewIntall));
      //   } else {
      //     emit(AuthenticationState.fail(errors: res.errors?.errorText));
      //     add(const AuthenticationEvent.loadedApp());
      //   }
      // } catch (e) {
      //   // logError(e.toString());
      //   emit(AuthenticationState.fail(errors: e.toString()));
      //   add(const AuthenticationEvent.loadedApp());
      // }
    }
  }
}
