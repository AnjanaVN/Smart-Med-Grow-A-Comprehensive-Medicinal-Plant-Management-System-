import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const _defaultLanguage = true; // Default language preference if not set

  // Function to get the language preference
  static Future<bool> getLanguagePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the preference exists, if not, return default value
    return prefs.getBool('isEnglish') ?? _defaultLanguage;
  }

  // Function to set the language preference
  static Future<void> setLanguagePreference(bool isEnglish) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isEnglish', isEnglish);
  }
}
