import 'package:fitflow/classes/ingredient.dart';
import 'package:fitflow/classes/macronutrients.dart';

// TODO: fix proportions

final List<Ingredient> IngredientsList = [
  Ingredient(
    name: "Olio",
    nutrients: MacroNutrients(
      carbohydrates: 0,
      proteins: 0,
      fats: 1
    )
  ),
  Ingredient(
    name: "Milk",
    nutrients: MacroNutrients(
      carbohydrates: 0.05,
      proteins: 0.034,
      fats: 0.01
    )
  ),
  Ingredient(
    name: "Vinegar",
    nutrients: MacroNutrients(
      carbohydrates: 0,
      proteins: 0.02,
      fats: 0.01
    )
  )
];

final int SCALE_FACTOR = 50;

final List GramsList = List<int>.generate(100, (i) => i + 1);

final List KcalList = List<int>.generate(30, (i) => i * SCALE_FACTOR);