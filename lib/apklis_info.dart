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
  ApklisInfo({
    required this.isInstalled,
    required this.versionCode,
    required this.versionName,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApklisInfo &&
        other.isInstalled == isInstalled &&
        other.versionCode == versionCode &&
        other.versionName == versionName;
  }

  @override
  int get hashCode =>
      isInstalled.hashCode ^ versionCode.hashCode ^ versionName.hashCode;
}
