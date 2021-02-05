import 'package:apklis_payment_checker/apklis_info.dart';
import 'package:device_apps/device_apps.dart';

class ApklisInfoCheck {
  /// Devuelve la siguiente información sobre Apklis
  /// [bool] isInstalled
  /// [int] versionCode
  /// [String] versionName
  static Future<ApklisInfo> getApklisInfo() async {
    Application app = await DeviceApps.getApp('cu.uci.android.apklis');
    if (app != null) {
      return ApklisInfo(true, app.versionCode, app.versionName);
    } else {
      return ApklisInfo(false, 0, '');
    }
  }
}
