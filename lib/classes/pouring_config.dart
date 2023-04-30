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
}