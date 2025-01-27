import 'package:shared_preferences/shared_preferences.dart';
import 'package:tut_app/presentation/resources/language_manager.dart';

const String prefsKeyLang = "PrefsKeyLang";
const String prefsKeyOnBoardingScreenViewed = "prefsKeyOnBoardingScreenViewed";
const String prefsKeyIsUserLoggedIn = "prefsKeyIsUserLoggedIn";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLang);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.english.getLanguage();
    }
  }

  Future<void> setOnboardingScreenViewed() async{
    _sharedPreferences.setBool(prefsKeyOnBoardingScreenViewed, true);
  }

  Future<void> setIsUserLoggedIn() async{
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isOnBoardingScreenViewed()async{
    return _sharedPreferences.getBool(prefsKeyOnBoardingScreenViewed) ?? false;
  }
  
  Future<bool> isUserLoggedIn()async{
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }
}
