import 'package:lyriverse/core/local/data_source/local_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefClient implements LocalClient {
  final SharedPreferences sharedPreferences;

  const PrefClient({required this.sharedPreferences});

  @override
  Future<int> getInt(String key) async {
    final int? value = sharedPreferences.getInt(key);

    if (value == null) {}

    return value!;
  }

  @override
  Future<String> getString(String key) async {
    final String? value = sharedPreferences.getString(key);

    if (value == null) {}

    return value!;
  }

  @override
  Future<void> setInt(String key, int value) async {
    await sharedPreferences.setInt(key, value);
  }

  @override
  Future<void> setString(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }
}
