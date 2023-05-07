import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/recipe.dart';
import 'package:fitflow/classes/step.dart';

final List<Recipe> recipes = [
  Recipe(
      "Banana Nut", RecipeDifficulty.hard, 5, "1.png",
      [
        Step("Aggiungiamo qualcosa", "bla bla bal", PouringConfig(5, 2)),
        Step("Mescoliamo per bene", "bla", null)
      ]
  ),
  Recipe(
      "Berry Blast", RecipeDifficulty.hard, 5, "2.png",
      [
        Step("Aggiungiamo qualcosa", "bla bla bal", PouringConfig(5, 2)),
        Step("Mescoliamo per bene", "bla", null)
      ]
  ),
  Recipe(
      "Green Machine", RecipeDifficulty.hard, 5, "3.png",
      [
        Step("Aggiungiamo qualcosa", "bla bla bal", PouringConfig(5, 2)),
        Step("Mescoliamo per bene", "bla", null)
      ]
  ),
  Recipe(
      "Coffee Lover's", RecipeDifficulty.hard, 5, "4.png",
      [
        Step("Aggiungiamo qualcosa", "bla bla bal", PouringConfig(5, 2)),
        Step("Mescoliamo per bene", "bla", null)
      ]
  ),
  Recipe(
      "Mango Lassi", RecipeDifficulty.hard, 5, "5.png",
      [
        Step("Aggiungiamo qualcosa", "bla bla bal", PouringConfig(5, 2)),
        Step("Mescoliamo per bene", "bla", null)
      ]
  ),
  Recipe(
      "Tropical Paradise", RecipeDifficulty.hard, 5, "6.png",
      [
        Step("Aggiungiamo qualcosa", "bla bla bal", PouringConfig(5, 2)),
        Step("Mescoliamo per bene", "bla", null)
      ]
  ),
];