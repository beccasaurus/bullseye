class SpecExample {

  static bool raiseExceptions;

  String name;

  bool hasBeenRun;

  var fn;

  var result;

  var exception;

  SpecExample([String name = null, var fn = null]) {
    this.name       = name;
    this.fn         = fn;
    this.hasBeenRun = false;
  }

  // Runs the function defined with this example, 
  // if it hasn't already been run.
  void run() {
    if (! hasBeenRun) {
      hasBeenRun = true;
      _runFunction();
    }
  }

  void _runFunction() {
    if (fn == null) {
      result = SpecExampleResult.pending;
    } else {
      try {
        fn();
        result = SpecExampleResult.passed;
      } catch (ExpectException ex) {
        result    = SpecExampleResult.failed;
        exception = ex;
      } catch (Exception ex) {
        result    = SpecExampleResult.error;
        exception = ex;
      }
    }
    if (SpecExample.raiseExceptions && exception != null)
      throw exception;
  }
}
