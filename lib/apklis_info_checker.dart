import 'package:apklis_payment_checker/apklis_info.dart';
import 'package:device_apps/device_apps.dart';

/// La clase ApklisInfoCheck chequea si existe la aplicación apklis
class ApklisInfoCheck {
  /// Devuelve la siguiente información sobre Apklis
  /// [bool] isInstalled `true` si esta instalado `false` en caso contrario
  /// [int] versionCode `0` si no existe el paquete
  /// [String] versionName `''` si no existe el paquete
  static Future<ApklisInfo> getApklisInfo() async {
    Application app = await DeviceApps.getApp('cu.uci.android.apklis');
    if (app != null) {
      return ApklisInfo(true, app.versionCode, app.versionName);
    } else {
      return ApklisInfo(false, 0, '');
    }
  }
}
