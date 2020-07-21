import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  // Instance
  SharedPreferences sharedPreferences;

  // Constructor
  SharedPreferencesHelper({
    @required this.sharedPreferences,
  });

  bool getBool(String key) {
    return sharedPreferences.getBool(key);
  }

  int getInt(String key) {
    return sharedPreferences.getInt(key);
  }

  String getString(String key) {
    return sharedPreferences.getString(key);
  }

  setBool(String key, bool value) {
    return sharedPreferences.setBool(key, value);
  }

  setInt(String key, int value) {
    return sharedPreferences.setInt(key, value);
  }

  setString(String key, String value) {
    return sharedPreferences.setString(key, value);
  }
}
