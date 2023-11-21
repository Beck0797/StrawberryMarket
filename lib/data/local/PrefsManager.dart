import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  static late final SharedPreferences instance;

  static const String accessToken = "access_token";
  static const String refreshToken = "refresh_token";

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static bool? getBool(String key) => instance.getBool(key);

  static Future<bool> setBool(String key, bool value) =>
      instance.setBool(key, value);

  static String? getStr(String key) => instance.getString(key);

  static Future<bool> setStr(String key, String value) =>
      instance.setString(key, value);

  static int? getInt(String key) => instance.getInt(key);

  static Future<bool> setInt(String key, int value) =>
      instance.setInt(key, value);
}
