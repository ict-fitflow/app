import 'dart:convert';

import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/user.dart';
import 'package:fitflow/mocks/pouring.dart';
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
        history: List<PourHistory>.from(pouring_history),
        custom_config: pouring_configs,
        goal: DailyGoal(intake: 0, enabled: false),
        bluetooth_devices: {}
      );
      await prefs.setString("user", _user.toString());
    }
    // otherwise load
    else {
      Map<String, dynamic> userprofsmap = jsonDecode(userprof);
      print(userprofsmap);
      _user = User.fromJSON(userprofsmap);
    }

    _user.history.sort((PourHistory a, PourHistory b) => a.date.isBefore(b.date) == true ? 1 : -1);
  }

  void add_pour(PouringConfig conf) {
    _user.history.insert(0, PourHistory(config: conf, date: DateTime.now()));
    update();
  }

  void add_bluetooth_device(String address) {
    _user.bluetooth_devices.add(address);
    update();
  }

  bool is_paired_device(String address) {
    return _user.bluetooth_devices.contains(address);
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

  List<PouringConfig> get configs => _user.custom_config;

  void add_config(PouringConfig config) {
    _user.custom_config.add(config);
    update();
  }

  void delete_config(int index) {
    _user.custom_config.removeAt(index);
    update();
  }

  void reorder_config(int old_index, int new_index) {
    if (old_index < new_index) {
      new_index -= 1;
    }
    final PouringConfig item = _user.custom_config.removeAt(old_index);
    _user.custom_config.insert(new_index, item);
    update();
  }

  // update user profile
  void update() async {
    await prefs.setString("user", _user.toString());
    notifyListeners();
  }
}