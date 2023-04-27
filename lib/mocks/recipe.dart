import 'package:fitflow/class/pouring_config.dart';
import 'package:fitflow/class/recipe.dart';
import 'package:fitflow/class/step.dart';

final List<Recipe> recipes = [
  Recipe(
      "prima", RecipeDifficulty.hard, 5,
      [
        Step("Aggiungiamo qualcosa", "bla bla bal", PouringConfig(5, 2)),
        Step("Mescoliamo per bene", "bla", null)
      ]
  ),
];