import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/recipe.dart';
import 'package:fitflow/classes/step.dart';

final List<Recipe> recipes = [
  Recipe(
      "prima", RecipeDifficulty.hard, 5,
      [
        Step("Aggiungiamo qualcosa", "bla bla bal", PouringConfig(5, 2)),
        Step("Mescoliamo per bene", "bla", null)
      ]
  ),
];