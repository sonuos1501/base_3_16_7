import '../../../../models/auth/login_data.dart';
import '../../../../models/response/responses.dart';

mixin AuthApi {
  /// Login by username, password
  Future<Responses<LoginData>> loginByTraditional({
    required String userName,
    required String password,
  });
}
