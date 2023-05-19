import 'package:fitflow/classes/macronutrients.dart';
import 'package:fitflow/classes/step.dart';

enum RecipeDifficulty {
  easy,
  medium,
  hard
}

class Recipe {

  String name;
  RecipeDifficulty difficulty;
  MacroNutrients nutrients;
  List<Step> steps;
  late String path;

  Recipe(this.name, this.difficulty, this.nutrients, String image, this.steps) {
    path = "assets/recipes/$image";
  }
}