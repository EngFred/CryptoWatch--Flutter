import 'package:intl/intl.dart';

class CurrencyUtils {
  static String formatLargeNumber(double num) {
    if (num >= 1000000000) {
      return "\$${(num / 1000000000).toStringAsFixed(2)}B";
    } else if (num >= 1000000) {
      return "\$${(num / 1000000).toStringAsFixed(2)}M";
    } else {
      return NumberFormat.currency(symbol: "\$", decimalDigits: 0).format(num);
    }
  }
}
