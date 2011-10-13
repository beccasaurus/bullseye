class SpecExample {

  String name;

  bool hasBeenRun;

  var fn;

  var result;

  SpecExample([String name = null, var fn = null]) {
    this.name       = name;
    this.fn         = fn;
    this.hasBeenRun = false;
  }

  run() {
    if (! hasBeenRun) {
      hasBeenRun = true;
      _runFunction();
    }
  }

  _runFunction() {
    if (fn == null) {
      result = SpecExampleResult.pending;
    } else {
      try {
        fn();
        result = SpecExampleResult.passed;
      } catch (ExpectException ex) {
        result = SpecExampleResult.failed;
      } catch (Exception ex) {
        result = SpecExampleResult.error;
      }
    }
  }
}
