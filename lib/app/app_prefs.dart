import 'dart:ffi';
import 'dart:ui';

import 'package:flutter_advance_course/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANGUAGE = "PREFS_KEY_LANGUAGE";
const String PREFS_KEY_ONBOARDING_SCREEN = "PREFS_KEY_ONBOARDING_SCREEN";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "PREFS_KEY_TOKEN";

class AppPreferences {
  SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANGUAGE);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setLanguageChanged() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      // save prefs with english language
      _sharedPreferences.setString(
          PREFS_KEY_LANGUAGE, LanguageType.ENGLISH.getValue());
    } else {
      // save prefs with arabic language
      _sharedPreferences.setString(
          PREFS_KEY_LANGUAGE, LanguageType.ARABIC.getValue());
    }
  }

  Future<Locale> getLocal() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ARABIC.getValue()) {
      // return arabic local
      return ARABIC_LOCAL;
    } else {
      // return english local
      return ENGLISH_LOCAL;
    }
  }

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN) ?? false;
  }

  Future<void> setToken(String token) async {
    await _sharedPreferences.setString(PREFS_KEY_TOKEN, token);
  }

  Future<String> getToken() async {
    return _sharedPreferences.getString(PREFS_KEY_TOKEN) ?? "NO TOKEN SAVED";
  }

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREFS_KEY_IS_USER_LOGGED_IN);
  }
}
