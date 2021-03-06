import 'package:apklis_payment_checker/apklis_info.dart';
import 'package:device_apps_null_safety/device_apps_null_safety.dart';

/// La clase ApklisInfoCheck chequea si existe la aplicación Apklis.
class ApklisInfoCheck {
  /// Devuelve la siguiente información sobre Apklis.
  ///
  /// [bool] isInstalled `true` si esta instalada `false` en caso contrario.
  /// [int] versionCode `0` si no esta instalada.
  /// [String] versionName `''` si no esta instalada.
  static Future<ApklisInfo> getApklisInfo() async {
    Application? app = await DeviceApps.getApp('cu.uci.android.apklis');
    if (app != null) {
      return ApklisInfo(true, app.versionCode, app.versionName);
    } else {
      return ApklisInfo(false, 0, '');
    }
  }
}
