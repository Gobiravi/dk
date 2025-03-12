import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // Create an instance of FlutterSecureStorage
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Save a value
  static Future<void> save(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  // Retrieve a value
  static Future<String?> get(String key) async {
    return await _storage.read(key: key);
  }

  // Delete a value
  static Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  // Clear all values
  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
