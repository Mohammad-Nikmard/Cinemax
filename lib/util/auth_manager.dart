import 'package:cinemax/DI/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final SharedPreferences _preferences = locator.get();

  static Future<void> saveToken(String token) async {
    await _preferences.setString("token", token);
  }

  static String readToken() {
    return _preferences.getString("token") ?? "";
  }

  static Future<void> saveId(String id) async {
    await _preferences.setString("ID", id);
  }

  static String readId() {
    return _preferences.getString("ID") ?? "";
  }

  static Future<bool> isLogged() async {
    return (readToken() == "") ? false : true;
  }

  static Future<void> logOut() async {
    await _preferences.clear();
  }
}
