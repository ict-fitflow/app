class MacroNutrients {

  double carbohydrates;
  double proteins;
  double fats;

  MacroNutrients({ required this.carbohydrates, required this.proteins, required this.fats });

  // calories per gram
  double get cpg  => carbohydrates * 4 + proteins * 4 + fats * 9;

}