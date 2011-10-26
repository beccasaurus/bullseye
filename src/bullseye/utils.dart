class BullseyeUtils {
  static final RegExp classNamePattern = const RegExp(@"^Failed type check: type (.*) is not assignable to type BullseyeUtils");

  // This does evil to get the class/type name of the given object.
  // Once Dart has reflection, this evil won't be necessary  :)
  //
  // Note: this implementation won't currently work with dartc because TypeErrors aren't raised.
  static String getClassName(var object) {
    if (object == null)          return "null";
    if (object is BullseyeUtils) return "BullseyeUtils";

    try {
      _callingMeResultsInATypeError(object);
    } catch (TypeError error) {
      return classNamePattern.firstMatch(error.toString()).group(1);
    }
  }

  static BullseyeUtils _callingMeResultsInATypeError(var object) {
    return object; // the ONLY way this won't blow up is if a BullseyeUtils instance is passed.
  }
}
