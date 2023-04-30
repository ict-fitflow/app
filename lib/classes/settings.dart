import 'dart:convert';

class Settings {
  bool darkTheme;

  Settings({
    this.darkTheme = false
  });

  factory Settings.fromJSON(Map<String, dynamic> json) {
    return Settings(
      darkTheme: json['darkTheme']
    );
  }

  Map<String, dynamic> toJson() => {
    'darkTheme': darkTheme,
  };

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}