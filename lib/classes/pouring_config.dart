import 'package:fitflow/classes/params.dart';

class PouringConfig {

  int _quantity;
  int _what;

  PouringConfig(this._quantity, this._what);

  List<int> getConfig() {
    return [_quantity, _what];
  }

  void setConfig(List<int> config) {
    _quantity = config[0];
    _what = config[1];
  }

  @override
  String toString() {
    return "${quantity}g ${what}";
  }

  factory PouringConfig.fromJSON(Map<String, dynamic> json) {
    return PouringConfig(
      json['quantity'],
      json['what']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': _quantity,
      'what': _what
    };
  }

  int get quantity => GramsList[_quantity];
  String get what => IngredientsList[_what].name;
  double get calories => quantity * IngredientsList[_what].cpg;
}