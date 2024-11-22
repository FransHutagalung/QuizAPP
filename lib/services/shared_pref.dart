import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _onBoardingKey = "showOnBoarding";
  final prefs = SharedPreferences.getInstance();

  Future<bool> get_status_onboarding() async {
    final prefsInstance = await prefs;
    final pref = prefsInstance.getBool(_onBoardingKey);
    return pref ?? false;
  }

  static Future<void> setOnBoardingShown(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onBoardingKey, value);
  }
}
