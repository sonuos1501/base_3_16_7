import '../../utils/secure_storage/SecureStorageUtil.dart';
import 'constants/secure_storages.dart';
import 'secure_storage_helper.dart';

class SecureStorageHelperImpl implements SecureStorageHelper {
  @override
  Future<String> get authToken async =>
      SecureStorageUtil.getString(SecureStorages.auth_token);

  @override
  Future<void> saveAuthToken(String value) async =>
      SecureStorageUtil.setString(SecureStorages.auth_token, value);

  @override
  Future<void> removeAuthToken() async =>
      SecureStorageUtil.removeString(SecureStorages.auth_token);
}
