import 'package:fitflow/classes/step.dart';

enum RecipeDifficulty {
  easy,
  medium,
  hard
}

class Recipe {

  String name;
  RecipeDifficulty difficulty;
  int cal;
  List<Step> steps;
  late String path;

  Recipe(this.name, this.difficulty, this.cal, String image, this.steps) {
    path = "assets/recipes/$image";
  }
}