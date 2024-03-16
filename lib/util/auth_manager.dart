import 'dart:convert';

import 'package:cinemax/DI/service_locator.dart';
import 'package:cinemax/data/model/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final SharedPreferences _preferences = locator.get();
  static final ValueNotifier notifier = ValueNotifier(null);

  static final myUser = User(
    "",
    AuthManager.readId(),
    AuthManager.readEmail(),
    "123456",
  );

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
    _preferences.remove("ID");
    _preferences.remove("E-mail");
    _preferences.remove("user");
    notifier.value = null;
  }

  static void saveId(String id) async {
    await _preferences.setString("ID", id);
  }

  static String readId() {
    return _preferences.getString("ID") ?? "";
  }

  static void saveEmail(String email) async {
    await _preferences.setString("E-mail", email);
  }

  static String readEmail() {
    return _preferences.getString("E-mail") ?? "";
  }

  static Future<void> setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString("user", json);
  }

  static User getUser() {
    final json = _preferences.getString("user");

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
