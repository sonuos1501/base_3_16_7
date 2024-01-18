import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/repository.dart';
import '../../../models/channels/channel_info_data.dart';
part 'authentication_bloc.freezed.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

enum LoginType { google, kakao, naver, traditional }

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(this._repository) : super(const AuthenticationInitial()) {
    on<LoadedApp>(_loadedApp);
    on<LoggedIn>(_loggedIn);
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

    final detailChannel =
        await getChannelInfo(accessToken: token, userId: userId);

    if (token.isNotEmpty) {
      return emit(
        AuthenticationState.authenticated(
          userId: userId,
          token: token,
          loginType: loginType,
          channelInfoData: detailChannel,
        ),
      );
    }

    emit(
      AuthenticationState.unAuthenticated(
        appNewIntall: await _repository.appNewIntall,
      ),
    );
  }

  Future<ChannelInfoData?> getChannelInfo({
    required String accessToken,
    required int userId,
  }) async {
    // try {
    //   final res = await _repository.getChannelInfo(accessToken: accessToken, channelId: userId);
    //   final status = res.apiStatus ?? '';

    //   if (status == HttpStatus.ok.toString()) {
    //     return res.data;
    //   }

    // } catch (_) {}

    return null;
  }

  Future<void> _loggedIn(
    LoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationLoading());

    await _repository.saveAuthToken(event.token ?? '');
    await _repository.saveUserId(event.userId);
    await _repository.saveLoginType(event.loginType);

    final detailChannel = await getChannelInfo(
      accessToken: event.token ?? '',
      userId: event.userId,
    );

    return emit(
      AuthenticationState.authenticated(
        userId: event.userId,
        token: event.token ?? '',
        loginType: event.loginType,
        channelInfoData: detailChannel,
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
