import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnboardingStatusDB {
  static const _storage = FlutterSecureStorage();
  static const String _onboardingKey = 'seen_onboarding';

  /// Mark onboarding as seen
  static Future<void> setOnboardingSeen() async {
    await _storage.write(key: _onboardingKey, value: 'true');
  }

  /// Check if onboarding has been seen
  static Future<bool> hasSeenOnboarding() async {
    String? seen = await _storage.read(key: _onboardingKey);
    return seen == 'true';
  }
}
