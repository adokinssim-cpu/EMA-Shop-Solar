class Formatters {
  Formatters._();

  static String formatPrice(double price) {
    return '${price.toStringAsFixed(0)} FCFA';
  }

  static String formatNumber(double value) {
    return value.toStringAsFixed(0);
  }
}
