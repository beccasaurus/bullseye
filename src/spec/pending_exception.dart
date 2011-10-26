class SpecPendingException implements Exception {
  String message;

  SpecPendingException(this.message);

  String toString() => message;
}
