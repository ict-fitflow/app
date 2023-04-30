import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fitflow/classes/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {

  late final SharedPreferences prefs;
  late Settings _settings;

  SettingsProvider({ required this.prefs }) {
    _init();
  }

  void _init() async {
    String? userprefs = prefs.getString("settings");
    // if not in, create it
    if (userprefs == null) {
      _settings = Settings();
      await prefs.setString("settings", _settings.toString());
    }
    // otherwise load
    else {
      Map<String, dynamic> userprefsmap = jsonDecode(userprefs);
      _settings = Settings.fromJSON(userprefsmap);
    }
  }

  // update shared prefs
  void update() async {
    await prefs.setString("settings", _settings.toString());
    notifyListeners();
  }

  // first time entering the app
  clearSession() async {
    await prefs.reload();
    await prefs.clear();
    await prefs.setBool('firstTime', false);
    _init();
    notifyListeners();
  }

  // toggle theme
  toggleDarkTheme() {
    darkTheme = !darkTheme;
    update();
  }

  // darkTheme: getter e setter
  bool get darkTheme => _settings.darkTheme;
  set darkTheme(bool val) {
    _settings.darkTheme = val;
    update();
  }
}