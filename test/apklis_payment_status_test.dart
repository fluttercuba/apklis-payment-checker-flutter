import 'package:apklis_payment_checker/apklis_payment_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApklisPaymentStatus', () {
    test('support equality', () {
      final paymentStatus1 =
          ApklisPaymentStatus(paid: true, username: 'username');
      final paymentStatus2 =
          ApklisPaymentStatus(paid: true, username: 'username');

      expect(paymentStatus1, equals(paymentStatus2));
      expect(paymentStatus1.hashCode, equals(paymentStatus2.hashCode));
    });
  });
}
