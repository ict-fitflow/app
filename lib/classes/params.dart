import 'package:fitflow/classes/ingredient.dart';

final List<Ingredient> IngredientsList = [
  Ingredient(name: "Olio", cal: 9),
  Ingredient(name: "Milk", cal: 0.64),
  Ingredient(name: "Vinegar", cal: 0.12)
];

final List GramsList = List<int>.generate(100, (i) => i + 1);

final List KcalList = List<int>.generate(40, (i) => i * 100);