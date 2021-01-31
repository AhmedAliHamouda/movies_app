import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkThemeProvider with ChangeNotifier {
  final String key = "theme";
  SharedPreferences _preferences;
  bool _darkMode;

  bool get darkMode => _darkMode;

  DarkThemeProvider() {
    //_darkMode = false;
    _loadFromPreferences();
  }

  _initialPreferences() async {
    if (_preferences == null)
      _preferences = await SharedPreferences.getInstance();
  }

  _savePreferences() async {
    await _initialPreferences();
    _preferences.setBool(key, _darkMode);
  }

  _loadFromPreferences() async {
    await _initialPreferences();
    _darkMode = _preferences.getBool(key) ?? false;

    notifyListeners();
  }

  toggleChangeTheme() {
    _darkMode = !_darkMode;
    _savePreferences();
    notifyListeners();
  }
}
