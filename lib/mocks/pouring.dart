import 'dart:math';

import 'package:fitflow/classes/params.dart';
import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/user.dart';

List<PouringConfig> pouring_configs = [
  PouringConfig(9, 0),
  PouringConfig(19, 1),
  PouringConfig(29, 2)
];

int samples = 100;
Random rng = Random();
List<PourHistory> pouring_history = List.generate(samples, (index) {
  final diff = Duration(
    minutes: rng.nextInt(60),
    hours: rng.nextInt(24),
    days: rng.nextInt(20)
  );

  int quantity = rng.nextInt(GramsList.length);
  int what = rng.nextInt(IngredientsList.length);

  return PourHistory(
    config: PouringConfig(quantity, what),
    date: DateTime.now().subtract(diff)
  );
});

