class MacroNutrients {

  double carbohydrates;
  double proteins;
  double fats;

  MacroNutrients({ required this.carbohydrates, required this.proteins, required this.fats });

  // calories per gram
  double get cpg  => cal_carbohydrates + cal_proteins + cal_fats;
  double get cal_carbohydrates => carbohydrates * 4;
  double get cal_proteins => proteins * 4;
  double get cal_fats => fats * 9;

}