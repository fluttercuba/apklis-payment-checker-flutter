/// La clase ApklisInfo registra la información de la aplicación Apklis.
///
/// Registra si se encuentra instalada o no.
/// Registra el código de la versión.
/// Registra el nombre de la versión.
class ApklisInfo {
  /// El [isInstalled] almacena el valor en `true` si esta instalada
  /// y `false` en caso contrario.
  final bool isInstalled;

  /// El [versionCode] almacena el valor del código de la versión
  final int? versionCode;

  /// El [versionName] almacena el valor del nombre de la versión
  final String? versionName;

  /// Para crear una instancia de la clase [ApklisInfo]
  ApklisInfo(this.isInstalled, this.versionCode, this.versionName);
}
