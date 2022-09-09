import 'package:apklis_payment_checker/apklis_info.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApklisInfo', () {
    test('support equality', () {
      final apklisInfo1 = ApklisInfo(
        isInstalled: true,
        versionCode: 1,
        versionName: '1.0.0',
      );
      final apklisInfo2 = ApklisInfo(
        isInstalled: true,
        versionCode: 1,
        versionName: '1.0.0',
      );

      expect(apklisInfo1, equals(apklisInfo2));
      expect(apklisInfo1.hashCode, equals(apklisInfo2.hashCode));
    });
  });
}
