# Apklis Payment Checker para Flutter

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Pub Version](https://img.shields.io/pub/v/apklis_payment_checker)](https://pub.dev/packages/apklis_payment_checker)
[![tests](https://github.com/fluttercuba/apklis-payment-checker-flutter/workflows/tests/badge.svg?branch=main)](https://github.com/fluttercuba/apklis-payment-checker-flutter/actions?query=workflow%3Atests)
[![Last commit](https://img.shields.io/github/last-commit/fluttercuba/apklis-payment-checker-flutter.svg?style=flat)](https://github.com/fluttercuba/apklis-payment-checker-flutter/commits)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/fluttercuba/apklis-payment-checker-flutter)](https://github.com/fluttercuba/apklis-payment-checker-flutter/commits)
[![Github Stars](https://img.shields.io/github/stars/fluttercuba/apklis-payment-checker-flutter?style=flat&logo=github)](https://github.com/fluttercuba/apklis-payment-checker-flutter/stargazers)
[![Github Forks](https://img.shields.io/github/forks/fluttercuba/apklis-payment-checker-flutter?style=flat&logo=github)](https://github.com/fluttercuba/apklis-payment-checker-flutter/network/members)
[![Github Watchers](https://img.shields.io/github/watchers/fluttercuba/apklis-payment-checker-flutter?style=flat&logo=github)](https://github.com/fluttercuba/apklis-payment-checker-flutter)
[![GitHub contributors](https://img.shields.io/github/contributors/fluttercuba/apklis-payment-checker-flutter)](https://github.com/fluttercuba/apklis-payment-checker-flutter/graphs/contributors)

Plugin de Flutter para el chequeo de pagos de Apklis

Disponible en Pub.dev: <https://pub.dev/packages/apklis_payment_checker>

Para conocer como instalar seguir el siguiente enlace: <https://pub.dev/packages/apklis_payment_checker/install>

## Uso

```dart
var status = await ApklisPaymentChecker.isPurchased();
print(status.paid);
print(status.username);
```

Si se desea usar un nombre de paquete diferente al de la aplicación el método `isPurchased` puede recibirlo como parámetro:

```dart
final packageId = 'com.example.nova.prosalud';
var status = await ApklisPaymentChecker.isPurchased(packageId);
print(status.paid);
print(status.username);
```

Para conocer información sobre ApkLis:

```dart
var apklisInfo = await ApklisPaymentChecker.getApklistInfo();
print(apklisInfo.isInstalled);
print(apklisInfo.versionName);
print(apklisInfo.versionCode);
```

Ejemplo completo disponible en: <https://pub.dev/packages/apklis_payment_checker/example>
