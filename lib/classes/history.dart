import 'package:fitflow/classes/user.dart';

class DayIntake {
  List<PourHistory> pouring = [];

  int grams = 0;
  double calories = 0;
  double cal_carbohydrates = 0;
  double cal_proteins = 0;
  double cal_fats = 0;

  void add_pour(PourHistory ph) {
    pouring.add(ph);
    cal_carbohydrates += ph.config.nutrients.cal_carbohydrates;
    cal_proteins += ph.config.nutrients.cal_proteins;
    cal_fats += ph.config.nutrients.cal_fats;
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

      while (index < history.length && history[index].date.isAfter(i_days_ago)) {
        week_history[d].add_pour(history[index]);
        index++;
      }

    }
  }

}