// Exception that gets thrown when pending() is called 
// allowing us to stop executing of the running function 
// and mark the current example as pending.
class SpecPendingException implements Exception {
  var message;

  SpecPendingException(this.message);

  String toString() => message;
}
