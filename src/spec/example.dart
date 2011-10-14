class SpecExample {

  static List<Function> _beforeFunctions;
  static List<Function> _afterFunctions;

  // Registers the given callback so it will be 
  // fired every time any SpecExample is run()
  static void beforeRun(Function callback) => _beforeFunctions.add(callback);

  // Registers the given callback so it will be 
  // fired after every time any SpecExample is run()
  static void afterRun(Function callback) => _afterFunctions.add(callback);

  // The SpecDecribe that this example is in
  SpecDescribe describe;

  static bool raiseExceptions; // UNTESTED! TODO

  String name;

  Function fn;

  String result;

  Exception exception;

  SpecExample([SpecDescribe describe, String name = null, Function fn = null]) {
    if (_beforeFunctions == null) _beforeFunctions = new List<Function>();
    if (_afterFunctions == null)  _afterFunctions = new List<Function>();

    this.describe   = describe;
    this.name       = name;
    this.fn         = fn;
  }

  // If this spec is pending and a reason 
  // was given, this returns that reason.
  String get pendingReason() {
    if (result == SpecExampleResult.pending && exception is SpecPendingException)
      return exception.message;
    else
      return null;
  }

  bool get passed()  => result == SpecExampleResult.passed;
  bool get failed()  => result == SpecExampleResult.failed;
  bool get error()   => result == SpecExampleResult.error;
  bool get pending() => result == SpecExampleResult.pending;

  // Runs the function defined with this example, 
  // if it hasn't already been run.
  void run() {
    _beforeFunctions.forEach((fn) => fn(this));
    _runFunction();
    _afterFunctions.forEach((fn) => fn(this));
  }

  void _runFunction() {
    if (fn == null) {
      result = SpecExampleResult.pending;
    } else {
      if (SpecExample.raiseExceptions == true) {
        // Any Exceptions thrown will bubble up
        fn();
        result = SpecExampleResult.passed;
      } else {
        try {
          fn();
          result = SpecExampleResult.passed;
        } catch (ExpectException ex) {
          result    = SpecExampleResult.failed;
          exception = ex;
        } catch (SpecPendingException ex) {
          result    = SpecExampleResult.pending;
          exception = ex;
        } catch (Exception ex) {
          result    = SpecExampleResult.error;
          exception = ex;
        }
      }
    }
  }

}
