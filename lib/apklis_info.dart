/// La clase ApklisInfo registra la información de la aplicación apklis.
///
/// Registra si se encuentra instalado o no.
/// Registra el código de versión.
/// Registra el nombre de la versión.
class ApklisInfo {
  /// El [isInstalled]  almacena el valor en `true` si esta instalado
  /// y `false` en caso contrario
  final bool isInstalled;
  /// El [versionCode] el valor del codigo e versión
  final int versionCode;
  /// El [verisionName] almacena el valor del nombre de versión
  final String versionName;

  /// Para crear un apklis payment status llamar [ApklisInfo()]
  ApklisInfo(this.isInstalled, this.versionCode, this.versionName);
}
