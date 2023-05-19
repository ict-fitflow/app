import 'package:fitflow/classes/macronutrients.dart';
import 'package:fitflow/classes/pouring_config.dart';
import 'package:fitflow/classes/recipe.dart';
import 'package:fitflow/classes/step.dart';

final List<Recipe> recipes = [
  Recipe(
      "Banana Nut", RecipeDifficulty.hard,
      MacroNutrients(carbohydrates: 20, proteins: 20, fats: 21.2),
      "1.png",
      [
        Step("1 scoop chocolate protein powder", "", null),
        Step("1 banana", "", null),
        Step("125 ml unsweetened vanilla almond milk", "", PouringConfig(125, 1)),
        Step("125 ml unsweetened vanilla cashew milk", "", PouringConfig(125, 1)),
        Step("1 tbsp almond butter", "", null)
      ]
  ),
  Recipe(
      "Berry Blast", RecipeDifficulty.hard,
      MacroNutrients(carbohydrates: 20, proteins: 20, fats: 26.7),
      "2.png",
      [
        Step("1 scoop vanilla protein powder", "", null),
        Step("1 cup mixed berries (frozen or fresh)", "", null),
        Step("250 ml almond milk", "", PouringConfig(250, 1)),
        Step("1 tbsp honey", "", null)
      ]
  ),
  Recipe(
      "Green Machine", RecipeDifficulty.hard,
      MacroNutrients(carbohydrates: 20, proteins: 20, fats: 21.2),
      "3.png",
      [
        Step("1 scoop vanilla protein powder", "", null),
        Step("1 cup spinach", "", null),
        Step("1/2 avocado", "", null),
        Step("250 ml almond milk", "", PouringConfig(250, 1)),
        Step("1 tbsp honey", "", null)
      ]
  ),
  Recipe(
      "Coffee Lover's", RecipeDifficulty.hard,
      MacroNutrients(carbohydrates: 20, proteins: 20, fats: 15.6),
      "4.png",
      [
        Step("1 scoop chocolate protein powder", "", null),
        Step("125 ml cold coffee", "", PouringConfig(125, 3)),
        Step("1/2 banana", "", null),
        Step("250  ml almond milk", "", PouringConfig(250, 1))
      ]
  ),
  Recipe(
      "Mango Lassi", RecipeDifficulty.hard,
      MacroNutrients(carbohydrates: 20, proteins: 20, fats: 15.6),
      "5.png",
      [
        Step("1 scoop chocolate protein powder", "", null),
        Step("1/2 cup frozen mango chunks", "", null),
        Step("1/2 cup plain Greek yogurt", "", null),
        Step("125 ml unsweetened coconut milk", "", PouringConfig(125, 1)),
        Step("125 ml water", "", PouringConfig(125, 4))
      ]
  ),
  Recipe(
      "Tropical Paradise", RecipeDifficulty.hard,
      MacroNutrients(carbohydrates: 20, proteins: 20, fats: 21.2),
      "6.png",
      [
        Step("1 scoop chocolate protein powder", "", null),
        Step("1/2 cup pineapple chunks (frozen or fresh)", "", null),
        Step("1/2 banana", "", null),
        Step("250 ml coconut milk", "", PouringConfig(250, 1))
      ]
  ),
];