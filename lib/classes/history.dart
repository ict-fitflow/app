import 'package:fitflow/classes/user.dart';

class DayIntake {
  List<PourHistory> pouring = [];
  double calories = 0;

  void add_pour(PourHistory ph) {
    pouring.add(ph);
    calories += ph.config.calories;
  }
}

class UserHistory {

  List<DayIntake> week_history = List.generate(7, (index) => DayIntake());
  late int weekday;


  UserHistory(List<PourHistory> history) {
    int index = 0;
    weekday = DateTime.now().weekday - 1;

    for (int d = weekday; d > 0; d--) {
      int diff_days = weekday - d;
      final now = DateTime.now();
      final diff = Duration(days: diff_days, hours: now.hour, minutes: now.minute);
      DateTime i_days_ago = now.subtract(diff);

      // print("i: $i");

      while (index < history.length && history[index].date.isAfter(i_days_ago)) {
        week_history[d].add_pour(history[index]);
        index++;
        print("$d = ${week_history[d].calories}");
      }

    }
  }

}