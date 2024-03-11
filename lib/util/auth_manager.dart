import 'package:cinemax/DI/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final SharedPreferences _preferences = locator.get();

  static void saveToken(String token) {
    _preferences.setString("token", token);
  }

  static String readToken() {
    return _preferences.getString("token") ?? "";
  }

  static void saveId(String id) {
    _preferences.setString("ID", id);
  }

  static String readId() {
    return _preferences.getString("ID") ?? "";
  }

  static bool isLogged() {
    var token = readToken();
    return token.isNotEmpty;
  }

  static void logOut() {
    _preferences.clear();
  }
}
