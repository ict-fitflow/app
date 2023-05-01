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
        custom_config: pouring_configs,
        goal: DailyGoal(intake: 0, enabled: false)
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

  void add_pour(PouringConfig conf) {
    _user.history.add(PourHistory(config: conf, date: DateTime.now()));
    update();
  }

  List<PourHistory> get history => _user.history;

  // toggle daily goal
  get daily_goal => _user.goal;

  bool get daily_goal_enabled => _user.goal.enabled;
  set daily_goal_enabled(bool v) {
    _user.goal.enabled = v;
    update();
  }

  int get daily_goal_intake => _user.goal.intake;
  set daily_goal_intake(int v) {
    _user.goal.intake = v;
    update();
  }

  // update user profile
  void update() async {
    await prefs.setString("user", _user.toString());
    notifyListeners();
  }
}