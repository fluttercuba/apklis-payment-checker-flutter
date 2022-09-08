/// La clase ApklisPaymentStatus registra el estado de un pago.
///
/// Registra si esta pagado o no.
/// Registra el nombre de usuario que realiza la acción de chequeo.
class ApklisPaymentStatus {
  /// El [paid]  almacena el estado del Payment en true | false
  final bool paid;

  /// El [username] almacena el nombre de usuario.
  final String? username;

  /// Para crear un instancia de la clase [ApklisPaymentStatus]
  ApklisPaymentStatus({
    required this.paid,
    required this.username,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ApklisPaymentStatus &&
        other.paid == paid &&
        other.username == username;
  }

  @override
  int get hashCode => paid.hashCode ^ username.hashCode;
}
