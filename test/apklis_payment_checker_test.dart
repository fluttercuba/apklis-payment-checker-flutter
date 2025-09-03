import 'package:apklis_payment_checker/apklis_info.dart';
import 'package:apklis_payment_checker/apklis_payment_checker.dart';
import 'package:apklis_payment_checker/apklis_payment_status.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('apklis_payment_checker');

  const packageId = 'com.example.nova.prosalud';

  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('channel have one instance', () {
    expect(channel, equals(const MethodChannel('apklis_payment_checker')));
  });
  // TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
  test('getPackageName', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return {
          'packageName': packageId,
        };
      },
    );

    final packageName = await ApklisPaymentChecker.getPackageName();

    expect(packageName, equals(packageId));
  });

  group('check isPunchased', () {
    test('when the packageId parameter is null and the app is not paid',
        () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          if (methodCall.method == 'getPackageName') {
            return {
              'packageName': packageId,
            };
          }
          return {
            'paid': false,
            'username': null,
          };
        },
      );

      final status = await ApklisPaymentChecker.isPurchased();

      expect(
        status,
        equals(ApklisPaymentStatus(paid: false, username: null)),
      );
    });

    test('when the app is not paid', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return {
            'paid': false,
            'username': null,
          };
        },
      );

      final status = await ApklisPaymentChecker.isPurchased(packageId);

      expect(
        status,
        equals(ApklisPaymentStatus(paid: false, username: null)),
      );
    });

    test('when channel return null', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return null;
        },
      );

      final status = await ApklisPaymentChecker.isPurchased(packageId);

      expect(
        status,
        equals(ApklisPaymentStatus(paid: false, username: null)),
      );
    });

    test('when the app is paid', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return {
            'paid': true,
            'username': 'example',
          };
        },
      );

      final status = await ApklisPaymentChecker.isPurchased(packageId);

      expect(
        status,
        equals(ApklisPaymentStatus(paid: true, username: 'example')),
      );
    });
  });

  group('getApklisInfo', () {
    test('when the Apklis app is not intalled', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return {
            'isIntalled': false,
            'versionCode': null,
            'versionName': null,
          };
        },
      );

      final info = await ApklisPaymentChecker.getApklisInfo();

      expect(
        info,
        equals(
          ApklisInfo(
            isInstalled: false,
            versionCode: null,
            versionName: null,
          ),
        ),
      );
    });

    test('when the Apklis app is installed but no user is logged in', () async {
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        channel,
        (MethodCall methodCall) async {
          return {
            'isIntalled': true,
            'versionCode': null,
            'versionName': null,
          };
        },
      );

      final info = await ApklisPaymentChecker.getApklisInfo();

      expect(
        info,
        equals(
          ApklisInfo(
            isInstalled: true,
            versionCode: null,
            versionName: null,
          ),
        ),
      );
    });
  });
}
