import 'dart:async';

import 'package:apklis_payment_checker/apklis_payment_status.dart';
import 'package:flutter/services.dart';

class ApklisPaymentChecker {
  static const channel = const MethodChannel('apklis_payment_checker');

  static Future<String> getPackageName() async {
    final Map map = await channel.invokeMapMethod('getPackageName');
    final String packageName = map['packageName'];
    return packageName;
  }

  static Future<ApklisPaymentStatus> isPurchased([String packageId]) async {
    packageId ??= await getPackageName();
    final Map map = await channel.invokeMapMethod('isPurchased', packageId);
    return ApklisPaymentStatus(map['paid'], map['username']);
  }
}
