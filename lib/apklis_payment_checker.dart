import 'dart:async';

import 'package:apklis_payment_checker/apklis_info.dart';
import 'package:apklis_payment_checker/apklis_payment_status.dart';
import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
/// {@template apklis_payment_checker}
/// La clase ApklisPaymentChecker registra las funcionalidades de Apklis.
///
/// Registra la función para obtener el nombre del paquete.
/// Registra la función para comprobar si esta pagado o no.
/// Registra la función para obtener la información de Apklis.
/// {@endtemplate}
class ApklisPaymentChecker {
  /// Establece la comunicacion entre codigo de Kotlin/Android y Flutter/Dart.
  static const _channel = MethodChannel('apklis_payment_checker');

  /// Devuelve `String` con el nombre del paquete.
  static Future<String> getPackageName() async {
    final Map? map = await _channel.invokeMapMethod('getPackageName');

    final String packageName = map!['packageName'] as String;

    return packageName;
  }

  /// Devuelve `Future<ApklisPaymentStatus>` con la información del estado de pago.
  static Future<ApklisPaymentStatus> isPurchased([String? packageId]) async {
    packageId ??= await getPackageName();
    final Map? map = await _channel.invokeMapMethod('isPurchased', packageId);
    if (map == null) {
      return ApklisPaymentStatus(paid: false, username: null);
    }

    final paid = map['paid'] as bool;
    final username = map['username'] as String?;

    return ApklisPaymentStatus(paid: paid, username: username);
  }

  /// Devuelve `Future<ApklisInfo>` con la información de Apklis.
  static Future<ApklisInfo> getApklisInfo() async {
    final Map? map = await _channel.invokeMapMethod('getApklisInfo');

    final isIntalled = map!['isIntalled'] as bool;

    if (isIntalled) {
      final versionCode = map['versionCode'] as int?;
      final versionName = map['versionName'] as String?;

      return ApklisInfo(
        isInstalled: isIntalled,
        versionCode: versionCode,
        versionName: versionName,
      );
    }

    return ApklisInfo(
      isInstalled: false,
      versionCode: null,
      versionName: null,
    );
  }
}
