import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SaveTokenDB {
  static const _storage = FlutterSecureStorage();
  static const String _tokenKey = 'auth_token';
  static const String _roleKey = 'user_role'; // New key for role
  static const String _nameKey = 'user_role'; 
  static const String _imagePath = 'user_role'; 


  /// Save token and role securely
  static Future<void> saveTokenAndRole(String token, String role) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _roleKey, value: role);
  }

  /// Save token only (for Google login)
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Retrieve token securely
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Retrieve role securely
  static Future<String?> getRole() async {
    return await _storage.read(key: _roleKey);
  }

  /// Delete token and role (logout)
  static Future<void> deleteTokenAndRole() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _roleKey);
  }

   ///Save name and image path
  static Future<void> saveNameAndImage(String name, String imagePath) async {
    await _storage.write(key: _nameKey, value: name);
    await _storage.write(key: _imagePath, value: imagePath);
  }

  /// Retrieve name securely
  static Future<String?> getName() async {
    return await _storage.read(key: _nameKey);
  }

  /// Retrieve image path securely
  static Future<String?> getImagePath() async {
    return await _storage.read(key: _imagePath);
  }
}
