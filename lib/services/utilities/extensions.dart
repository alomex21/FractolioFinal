import 'dart:math';

extension Precision on double {
  double toPrecision(int fractionDigits) {
    double mod = pow(10, fractionDigits.toDouble()).toDouble();
    return ((this * mod).round().toDouble() / mod);
  }
}

extension Precision2 on double {
  double toPrecision2(int n) => double.parse(toStringAsFixed(n));
}
