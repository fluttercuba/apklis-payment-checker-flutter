# Apklis Payment Checker for Flutter

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Last commit](https://img.shields.io/github/last-commit/fluttercuba/apklis-payment-checker-flutter.svg?style=flat)](https://github.com/fluttercuba/apklis-payment-checker-flutter/commits)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/fluttercuba/apklis-payment-checker-flutter)](https://github.com/fluttercuba/apklis-payment-checker-flutter/commits)
[![Github Stars](https://img.shields.io/github/stars/fluttercuba/apklis-payment-checker-flutter?style=flat&logo=github)](https://github.com/fluttercuba/apklis-payment-checker-flutter/stargazers)
[![Github Forks](https://img.shields.io/github/forks/fluttercuba/apklis-payment-checker-flutter?style=flat&logo=github)](https://github.com/fluttercuba/apklis-payment-checker-flutter/network/members)
[![Github Watchers](https://img.shields.io/github/watchers/fluttercuba/apklis-payment-checker-flutter?style=flat&logo=github)](https://github.com/fluttercuba/apklis-payment-checker-flutter)
[![Website](https://img.shields.io/website?up_message=online&url=https%3A%2F%2Ffluttercuba.github.io/apklis-payment-checker-flutter)](https://fluttercuba.github.io/apklis-payment-checker-flutter)
[![GitHub contributors](https://img.shields.io/github/contributors/fluttercuba/apklis-payment-checker-flutter)](https://github.com/fluttercuba/apklis-payment-checker-flutter/graphs/contributors)

Flutter plugin for Apklis payment checking.

## Usage

```dart
final packageId = 'com.example.nova.prosalud';
var status = await ApklisPaymentChecker.isPurchased(packageId);
print(status.paid);
print(status.username);
```
