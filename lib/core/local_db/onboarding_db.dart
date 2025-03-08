import 'package:shared_preferences/shared_preferences.dart';

class OnboardingStatusDB {
  static const String _onboardingKey = 'seen_onboarding';

  /// Mark onboarding as seen
  static Future<void> setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  /// Check if onboarding has been seen
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenDialog = prefs.getBool(_onboardingKey) ?? false;
    return hasSeenDialog;
  }
}
