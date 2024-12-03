import 'package:shared_preferences/shared_preferences.dart';

/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 11/23/2023, Thursday

class SharedPreferencesService {
  static SharedPreferencesService? _instance;
  static late SharedPreferences _preferences;

  SharedPreferencesService._();

  factory SharedPreferencesService() {
    _instance ??= SharedPreferencesService._();
    return _instance!;
  }

  static Future<void> initializePreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  String getStringValue(String data) {
    return _preferences.getString(data) ?? '';
  }

  int? getIntValue(String data) {
    return _preferences.getInt(data);
  }

  double? getDoubleValue(String data) {
    return _preferences.getDouble(data);
  }

  bool? getBoolValue(String data) {
    return _preferences.getBool(data);
  }

  Future<bool> removeData(String key) async {
    return await _preferences.remove(key);
  }

  //TODO : Make switch case for this approach.
  void saveData(String key, dynamic value) {
    if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }
}
