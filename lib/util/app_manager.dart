import 'package:cinemax/DI/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppManager {
  static final SharedPreferences _sharedPreferences = locator.get();
  static const languagePrefsKey = 'languagePrefs';

  static void setLang(String langCode) async {
    await _sharedPreferences.setString(languagePrefsKey, langCode);
  }

  static String? getLnag() {
    return _sharedPreferences.getString(languagePrefsKey);
  }

  static Future<void> setFirstTime(bool isFirst) async {
    await _sharedPreferences.setBool("FirstUsage", isFirst);
  }

  static bool isFistTime() {
    return _sharedPreferences.getBool("FirstUsage") ?? true;
  }

  static Future<void> setNotifications(bool trueORfalse) async {
    await _sharedPreferences.setBool("Notif", trueORfalse);
  }

  static bool getNotif() {
    return _sharedPreferences.getBool("Notif") ?? true;
  }

  static Future<void> setDeviceToken(String token) async {
    await _sharedPreferences.setString("FCM", token);
  }

  static String readDeviceToken() {
    return _sharedPreferences.getString("FCM") ?? "";
  }
}
