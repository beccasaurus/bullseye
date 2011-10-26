class BullseyePendingException implements Exception {
  String message;

  BullseyePendingException(this.message);

  String toString() => message;
}
