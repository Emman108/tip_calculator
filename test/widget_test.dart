
import 'package:flutter_test/flutter_test.dart';
import 'package:tip_calculator/main.dart';

void main() {
  group('Tip Calculator Tests', () {
    test('Computes 15 percent tip correctly', () {
      final result = computeTip(500, 15);

      expect(result.tip, 75.0);
      expect(result.total, 575.0);
    });

    test('Computes 10 percent tip correctly', () {
      final result = computeTip(500, 10);

      expect(result.tip, 50.0);
      expect(result.total, 550.0);
    });

    test('Parses valid bill amount', () {
      expect(parseBill('500'), 500.0);
    });

    test('Rejects invalid bill amount', () {
      expect(parseBill('abc'), isNull);
    });
  });
}
