import 'package:provider_stub/res/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _preferences;

  // Initializes SharedPreferences instance
  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Sets a string value in SharedPreferences
  static Future setUser(String value) async {
    await _preferences?.setString(AppStrings.userKey, value);
  }

  // Retrieves a string value from SharedPreferences
  static String? getUser() {
    return _preferences?.getString(AppStrings.userKey);
  }

  // Removes a specific key from SharedPreferences
  static Future removeParticularKey(String key) async {
    await _preferences?.remove(key);
  }

  // Clears all data from SharedPreferences
  static Future clear() async {
    await _preferences?.clear();
  }
}
