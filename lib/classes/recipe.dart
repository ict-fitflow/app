import 'package:fitflow/classes/step.dart';

enum RecipeDifficulty {
  easy,
  medium,
  hard
}

class Recipe {

  String name;
  RecipeDifficulty difficulty;
  int time;
  List<Step> steps;

  Recipe(this.name, this.difficulty, this.time, this.steps);
}