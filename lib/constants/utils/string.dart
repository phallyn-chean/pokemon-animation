import 'package:intl/intl.dart';

String removeTrailingZero(double n) {
  final formater = NumberFormat()
    ..minimumFractionDigits = 0
    ..maximumFractionDigits = 2;

  return formater.format(n);
}
