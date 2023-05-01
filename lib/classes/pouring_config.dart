class PouringConfig {

  int quantity;
  int what;

  PouringConfig(this.quantity, this.what);

  List<int> getConfig() {
    return [quantity, what];
  }

  void setConfig(List<int> config) {
    quantity = config[0];
    what = config[1];
  }

  factory PouringConfig.fromJSON(Map<String, dynamic> json) {
    return PouringConfig(
      json['quantity'],
      json['what']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'what': what
    };
  }
}