import 'dart:convert';

import 'package:fitflow/classes/pouring_config.dart';

class User {

  List<PourHistory> history;
  List<PouringConfig> custom_config;
  Set<String> bluetooth_devices;
  DailyGoal goal;

  User({ required this.history, required this.custom_config, required this.goal, required this.bluetooth_devices });

  factory User.fromJSON(Map<String, dynamic> json) {
    List<PourHistory> history = (json['history'] as List<dynamic>).map((c) => PourHistory.fromJSON(c)).toList();
    List<PouringConfig> custom_config = (json['custom_config'] as List<dynamic>).map((c) => PouringConfig.fromJSON(c)).toList();

    return User(
      history: history,
      custom_config: custom_config,
      goal: DailyGoal.fromJSON(json['daily_goal']),
      bluetooth_devices: json['bluetooth_devices']
    );
  }

  Map<String, dynamic> toJson() => {
    'history': history,
    'custom_config': custom_config,
    'daily_goal': goal,
    'bluetooth_devices': bluetooth_devices.toList()
  };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class DailyGoal {

  int intake;
  bool enabled;

  DailyGoal({ required this.intake, required this.enabled });

  factory DailyGoal.fromJSON(Map<String, dynamic> json) {
    return DailyGoal(
      intake: json['intake'],
      enabled: json['enabled']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'intake': intake,
      'enabled': enabled
    };
  }
}

class PourHistory {

  PouringConfig config;
  DateTime date;

  PourHistory({ required this.config, required this.date});

  factory PourHistory.fromJSON(Map<String, dynamic> json) {
    return PourHistory(
        config: PouringConfig.fromJSON(json['config']),
        date: DateTime.parse(json['date'])
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'config': config.toJson(),
      'date': date.toString()
    };
  }
}