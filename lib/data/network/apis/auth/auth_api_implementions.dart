import 'package:dio/dio.dart';
import '../../../../configs/env/env_state.dart';
import '../../../../models/auth/login_data.dart';
import '../../../../models/response/responses.dart';
import '../../../../utils/custom_log/custom_log.dart';
import '../../../../utils/https/HttpHelper.dart';
import '../../../../utils/utils.dart';
import '../../constants/endpoints.dart';
import 'auth_api.dart';

class AuthApiImpl implements AuthApi {
  @override
  Future<Responses<LoginData>> loginByTraditional({
    required String userName,
    required String password,
  }) async {
    try {
      final bodies = <String, dynamic>{};
      bodies['server_key'] = EnvValue.env.serverKey;
      bodies['username'] = userName;
      bodies['password'] = password;
      bodies['device_id'] = await Utils.getDeviceIdentifier() ?? '';

      final res = await HttpHelper.requestApi(
        Endpoints.login,
        FormData.fromMap(bodies),
        HttpMethod.post,
        false,
        body: true,
      );
      return Responses.fromJson(res.data, LoginData.fromJson);
    } catch (e) {
      logError(e.toString());
      rethrow;
    }
  }
}
