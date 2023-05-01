import 'dart:convert';

import 'package:fitflow/classes/pouring_config.dart';

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

class User {

  List<PourHistory> history;
  List<PouringConfig> custom_config;

  User({ required this.history, required this.custom_config });

  factory User.fromJSON(Map<String, dynamic> json) {
    List<PourHistory> history = (json['history'] as List<dynamic>).map((c) => PourHistory.fromJSON(c)).toList();
    List<PouringConfig> custom_config = (json['custom_config'] as List<dynamic>).map((c) => PouringConfig.fromJSON(c)).toList();

    return User(
      history: history,
      custom_config: custom_config
    );
  }

  Map<String, dynamic> toJson() => {
    'history': history,
    'custom_config': custom_config
  };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}