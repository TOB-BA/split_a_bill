extension DoubleExtension on double {
  String addCurrencySymbolToDouble() {
    return '€ ${toStringAsFixed(2)}';
  }
}

extension StringExtension on String {
  String addCurrencySymbolToString() {
    return '€ $this';
  }
}
