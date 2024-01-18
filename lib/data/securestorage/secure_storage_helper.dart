
mixin SecureStorageHelper {

  /// General Method: ---------------------------------------------------------------------------
  Future<String> get authToken;

  Future<void> saveAuthToken(String value);

  Future<void> removeAuthToken();

}
