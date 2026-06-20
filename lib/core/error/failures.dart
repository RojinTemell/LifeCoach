sealed class Failure {
  const Failure(this.message);

  final String message;
}

final class PermissionDeniedFailure extends Failure {
  const PermissionDeniedFailure() : super('Sağlık verisi izni verilmedi.');
}

final class HealthDataFailure extends Failure {
  const HealthDataFailure([super.message = 'Sağlık verisi okunamadı.']);
}
