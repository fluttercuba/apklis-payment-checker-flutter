import 'dart:async';

import 'package:apklis_payment_checker/apklis_payment_status.dart';
import 'package:flutter/services.dart';

class ApklisPaymentChecker {
  static const channel = const MethodChannel('apklis_payment_checker');

  static Future<ApklisPaymentStatus> isPurchased(String packageId) async {
    final Map map = await channel.invokeMapMethod("isPurchased", packageId);
    return ApklisPaymentStatus(map["paid"], map["username"]);
  }
}
