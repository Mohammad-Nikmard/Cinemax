import 'package:cinemax/DI/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final SharedPreferences _preferences = locator.get();
  static final ValueNotifier notifier = ValueNotifier(null);

  static void saveToken(String token) async {
    await _preferences.setString("access_token", token);
    notifier.value = token;
  }

  static String readToken() {
    return _preferences.getString("access_token") ?? "";
  }

  static bool isLogged() {
    var token = readToken();
    return token.isNotEmpty;
  }

  static void logOut() {
    _preferences.remove("access_token");
    notifier.value = null;
  }

  static void saveId(String id) async {
    await _preferences.setString("ID", id);
  }

  static String readId() {
    return _preferences.getString("ID") ?? "";
  }
}
