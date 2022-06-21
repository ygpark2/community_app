import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPrefHelper {
  static const String _isDarkTheme = "isDarkTheme";
  static const String _isIndonesian = "isIndonesian";
  static const String _token = "TOKEN";

  final SharedPreferences preferences;

  SharedPrefHelper({required this.preferences});

  Future<String?> getValueToken() async {
    return preferences.getString(_token);
    // return preferences.getString(_token) ??= "false";
  }

  Future setValueToken(String value) async {
    preferences.setString(_token, value);
  }

  Future removeToken() async {
    preferences.remove(_token);
  }

  Future<bool> getValueDarkTheme() async {
    return preferences.getBool(_isDarkTheme) ?? false;
  }

  Future setValueDarkTheme(bool value) async {
    preferences.setBool(_isDarkTheme, value);
  }

  Future<bool> getValueIndonesianLanguage() async {
    return preferences.getBool(_isIndonesian) ?? false;
  }

  Future setValueIndonesianLanguage(bool value) async {
    preferences.setBool(_isIndonesian, value);
  }
}
