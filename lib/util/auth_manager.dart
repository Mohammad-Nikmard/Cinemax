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
    _preferences.remove("E-mail");
    _preferences.remove("RecordID");
    _preferences.remove("Name");
    notifier.value = null;
  }

  static void saveRecordID(String id) async {
    await _preferences.setString("RecordID", id);
  }

  static String readRecordID() {
    return _preferences.getString("RecordID") ?? "";
  }

  static Future<void> saveNum(String phoneNumber) async {
    await _preferences.setString("number", phoneNumber);
  }

  static String readNum() {
    return _preferences.getString("number") ?? "";
  }

  static void saveEmail(String email) async {
    await _preferences.setString("E-mail", email);
  }

  static String readEmail() {
    return _preferences.getString("E-mail") ?? "";
  }

  static void saveName(String name) async {
    await _preferences.setString("Name", name);
  }

  static String readName() {
    return _preferences.getString("Name") ?? "";
  }
}
