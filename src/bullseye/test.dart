class BullseyeTest {

  static List<Function> _beforeFunctions;
  static List<Function> _afterFunctions;
  static void beforeRun(Function callback) => _beforeFunctions.add(callback);
  static void afterRun(Function callback) => _afterFunctions.add(callback);

  BullseyeTestFixture testFixture;

  static bool throwExceptions;

  String description;

  Function fn;

  String result;

  Exception exception;

  BullseyeTest([BullseyeTestFixture testFixture, String description = null, Function fn = null]) {
    if (_beforeFunctions == null) _beforeFunctions = new List<Function>();
    if (_afterFunctions == null)  _afterFunctions = new List<Function>();

    this.testFixture   = testFixture;
    this.description       = description;
    this.fn         = fn;
  }

  String get pendingReason() {
    if (result == BullseyeTestResult.pending && exception is SpecPendingException)
      return exception.message;
    else
      return null;
  }

  bool get passed()  => result == BullseyeTestResult.passed;
  bool get failed()  => result == BullseyeTestResult.failed;
  bool get error()   => result == BullseyeTestResult.error;
  bool get pending() => result == BullseyeTestResult.pending;

  void run() {
    _beforeFunctions.forEach((fn) => fn(this));
    _runFunction();
    _afterFunctions.forEach((fn) => fn(this));
  }

  void _runFunction() {
    if (fn == null) {
      result = BullseyeTestResult.pending;
    } else {
      if (BullseyeTest.throwExceptions == true) {
        fn();
        result = BullseyeTestResult.passed;
      } else {
        try {
          fn();
          result = BullseyeTestResult.passed;
        } catch (ExpectException ex) {
          result    = BullseyeTestResult.failed;
          exception = ex;
        } catch (SpecPendingException ex) {
          result    = BullseyeTestResult.pending;
          exception = ex;
        } catch (Exception ex) {
          result    = BullseyeTestResult.error;
          exception = ex;
        }
      }
    }
  }

}
