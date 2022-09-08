import 'dart:async';

import 'package:apklis_payment_checker/apklis_info.dart';
import 'package:apklis_payment_checker/apklis_payment_status.dart';
import 'package:flutter/services.dart';

/// La clase ApklisPaymentChecker registra las funcionalidades de Apklis.
///
/// Registra la función para obtener el nombre del paquete.
/// Registra la función para comprobar si esta pagado o no.
/// Registra la función para obtener la información de Apklis.
class ApklisPaymentChecker {
  /// Establece la comunicacion entre codigo de Kotlin/Android y Flutter/Dart.
  static const channel = const MethodChannel('apklis_payment_checker');

  /// Devuelve `String` con el nombre del paquete.
  static Future<String> getPackageName() async {
    final Map map = await (channel.invokeMapMethod('getPackageName')
        as Future<Map<dynamic, dynamic>>);
    final String packageName = map['packageName'];
    return packageName;
  }

  /// Devuelve `Future<ApklisPaymentStatus>` con la información del estado de pago.
  static Future<ApklisPaymentStatus> isPurchased([String? packageId]) async {
    packageId ??= await getPackageName();
    final Map? map = await (channel.invokeMapMethod('isPurchased', packageId));
    if (map == null) {
      return ApklisPaymentStatus(false, null);
    }
    return ApklisPaymentStatus(map['paid'], map['username']);
  }

  /// Devuelve `Future<ApklisInfo>` con la información de Apklis.
  static Future<ApklisInfo> getApklisInfo() async {
    final Map map = await (channel.invokeMapMethod('getApklisInfo')
        as Future<Map<dynamic, dynamic>>);

    final isIntalled = map['isIntalled'] as bool;

    if (isIntalled) {
      final versionCode = map['versionCode'] as int?;
      final versionName = map['versionName'] as String?;

      return ApklisInfo(isIntalled, versionCode, versionName);
    }

    return ApklisInfo(false, null, null);
  }
}
