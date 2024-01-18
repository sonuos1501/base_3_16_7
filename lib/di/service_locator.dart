import 'package:get_it/get_it.dart';
import '../../configs/env/env_state.dart';
import '../../data/securestorage/secure_storage_helper.dart';
import '../../data/sharedpref/shared_preference_helper.dart';
import '../../utils/navigator/navigator.dart';
import '../blocs/common_blocs/authentication/authentication_bloc.dart';
import '../blocs/common_blocs/language/language_bloc.dart';
import '../blocs/common_blocs/theme/theme_bloc.dart';
import '../data/network/apis/auth/auth_api.dart';
import '../data/network/apis/auth/auth_api_implementions.dart';
import '../data/repository.dart';
import '../data/securestorage/secure_storage_helper_implementions.dart';
import '../data/sharedpref/shared_preference_helper_implementions.dart';
import '../ui/login/bloc/login_bloc.dart';

final sl = GetIt.instance;

// @InjectableInit()
// Future<void> setupLocator() async => await $initGetIt(sl);

void setupLocator({required EnvState env}) {
  //phải là lazySingleton thì AuthenBloc sẽ đc khởi tạo khi mình gọi tại file app line 60.
  //lúc đó context truyền vào mới ko null
  sl

    /// lazySingleton:-----------------------------------------------------------------
    ..registerLazySingleton<SharedPreferenceHelper>(
      SharedPreferenceHelperImpl.new,
    )
    ..registerLazySingleton<SecureStorageHelper>(SecureStorageHelperImpl.new)
    // ..registerLazySingleton<FirebaseAnalytics>(
    //   () => FirebaseAnalytics.instance,
    // )
    // ..registerLazySingleton<AnalyticsUtil>(
    //   () => AnalyticsUtil(sl<FirebaseAnalytics>()),
    // )

    /// factories:-----------------------------------------------------------------
    // nếu để ở đây là singleton thì sẽ lỗi vì singleton chỉ khởi tạo 1 instance cho toàn app khi build app
    // nên đăng nhập thành công rồi thì LoginBloc sẽ gọi func close và huỷ đi LoginBloc. từ sau ko ấn
    // đăng nhập lại đc nữa nên mình cần tạo là:
    // Factory (GetIt offers different ways how objects are registered that effect the lifetime of this objects)
    ..registerFactory(
      () => LoginBloc(
        sl<Repository>(),
        authenticationBloc: sl<AuthenticationBloc>(),
      ),
    )
    // ..registerFactoryParamAsync((param1, param2) => null)

    // ..registerFactory<GraphQLApiClient>(
    //   () => GraphQLApiClient(
    //     uri: env.baseUrlApi,
    //     // navigationService: navigationService,
    //   ),
    // )

    // async singletons:----------------------------------------------------------

    /// singletons:----------------------------------------------------------------
    ..registerSingleton(Navigation())

    /// api's:---------------------------------------------------------------------
    ..registerLazySingleton<AuthApi>(AuthApiImpl.new)

    // data sources
    // getIt.registerSingleton(PostDataSource(await getIt.getAsync<Database>()));

    /// repository:----------------------------------------------------------------
    ..registerSingleton(
      Repository(
        authApi: sl<AuthApi>(),
        sharedPrefsHelper: sl<SharedPreferenceHelper>(),
        secureStorageHelper: sl<SecureStorageHelper>(),
      ),
    )

    /// blocs:--------------------------------------------------------------------
    ..registerLazySingleton(() => ThemeBloc(sl<Repository>()))
    ..registerLazySingleton(() => LanguageBloc(sl<Repository>()))
    ..registerLazySingleton(() => AuthenticationBloc(sl<Repository>()));
  // ..registerLazySingleton(
  //   () =>
  //       BlocProvider.of<AuthenticationBloc>(NavigationService.currentContext),
  // )
  // ..registerLazySingleton(
  //   () => BlocProvider.of<TodoBloc>(NavigationService.currentContext),
  // )
  // ..registerLazySingleton(() => TodoFilterBloc(todoBloc: sl<TodoBloc>()))
  // ..registerLazySingleton<FlutterSecureStorage>(FlutterSecureStorage.new)
  // ..registerLazySingleton<SharedPreferencesClient>(
  //   SharedPreferencesClient.new,
  // )
}
