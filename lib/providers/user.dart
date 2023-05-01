import 'dart:convert';

import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/user.dart';
import 'package:fitflow/mocks/pouring_config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {

  late final SharedPreferences prefs;
  late User _user;

  UserProvider({ required this.prefs }) {
    _init();
  }

  void _init() async {
    String? userprof = prefs.getString("user");
    // if not in, create it
    if (userprof == null) {
      _user = User(
        history: [],
        custom_config: pouring_configs
      );
      await prefs.setString("user", _user.toString());
    }
    // otherwise load
    else {
      Map<String, dynamic> userprofsmap = jsonDecode(userprof);
      print(userprofsmap);
      _user = User.fromJSON(userprofsmap);
    }
  }

  // TODO: add custom config
  // TODO: remove custom config
  // TODO: swap custom config order
  // TODO: add element to history
  void add_pour(PouringConfig conf) {
    _user.history.add(PourHistory(config: conf, date: DateTime.now()));
    update();
  }

  List<PourHistory> get history => _user.history;

  // update user profile
  void update() async {
    await prefs.setString("user", _user.toString());
    notifyListeners();
  }
}