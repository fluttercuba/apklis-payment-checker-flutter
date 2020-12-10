import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:apklis_payment_checker/apklis_payment_checker.dart';

void main() {
  const MethodChannel channel = MethodChannel('apklis_payment_checker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ApklisPaymentChecker.platformVersion, '42');
  });
}
