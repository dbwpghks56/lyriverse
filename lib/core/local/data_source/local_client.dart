abstract interface class LocalClient {
  Future<void> setString(String key, String value);
  Future<void> setInt(String key, int value);
  Future<String> getString(String key);
  Future<int> getInt(String key);
}
