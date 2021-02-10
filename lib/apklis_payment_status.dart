/// La clase ApklisPaymentStatus registra el estado de un pago.
///
/// Registra si esta pagado o no.
/// Registra el nombre de usario que realiza la acción de chequeo.
class ApklisPaymentStatus {
  /// El [paid]  almacena el estado del Payment en true | false
  final bool paid;
  /// El [username] almacena el nombre de usaruio
  final String username;

  /// Para crear un apklis payment status llamar [ApklisPaymentSatus()]
  ApklisPaymentStatus(this.paid, this.username);
}
