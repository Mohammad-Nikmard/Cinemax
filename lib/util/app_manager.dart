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
}
