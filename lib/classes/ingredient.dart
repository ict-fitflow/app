import 'package:fitflow/classes/macronutrients.dart';

class Ingredient {
  String name;
  MacroNutrients nutrients;

  double get cpg => nutrients.cpg;

  Ingredient({ required this.name, required this.nutrients });
}