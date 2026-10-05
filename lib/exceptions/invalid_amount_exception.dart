class InvalidAmountException implements Exception {
  final String message;

  InvalidAmountException(this.message);

  @override
  String toString() => 'InvalidAmountException: $message';
}
