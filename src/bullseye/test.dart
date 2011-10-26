class BullseyeTest {

  static List<Function> _beforeFunctions;
  static List<Function> _afterFunctions;
  static void beforeRun(Function callback) => _beforeFunctions.add(callback);
  static void afterRun(Function callback) => _afterFunctions.add(callback);

  BullseyeTestFixture parent;

  static bool throwExceptions; // static for closure eis closuresThrowExceptions

  String description;
  Function fn;
  String status;
  Exception exception;

  String get fullDescription() {
    String desc = (parent == null) ? "" : parent.fullDescription;
    if (description != null) {
      if (desc.length > 0)
        desc += " ";
      desc = desc + description;
    }
    return desc;
  }

  BullseyeTest([BullseyeTestFixture parent, String description = null, Function fn = null]) {
    if (_beforeFunctions == null) _beforeFunctions = new List<Function>();
    if (_afterFunctions == null)  _afterFunctions = new List<Function>();

    this.parent   = parent;
    this.description       = description;
    this.fn         = fn;
  }

  String get pendingReason() {
    if (status == BullseyeTestStatus.pending && exception is SpecPendingException)
      return exception.message;
    else
      return null;
  }

  bool get passed()  => status == BullseyeTestStatus.passed;
  bool get failed()  => status == BullseyeTestStatus.failed;
  bool get error()   => status == BullseyeTestStatus.error;
  bool get pending() => status == BullseyeTestStatus.pending;

  void run() {
    _beforeFunctions.forEach((fn) => fn(this));
    _runFunction();
    _afterFunctions.forEach((fn) => fn(this));
  }

  void _runFunction() {
    if (fn == null) {
      status = BullseyeTestStatus.pending;
    } else {
      if (BullseyeTest.throwExceptions == true) {
        fn();
        status = BullseyeTestStatus.passed;
      } else {
        try {
          fn();
          status = BullseyeTestStatus.passed;
        } catch (ExpectException ex) {
          status    = BullseyeTestStatus.failed;
          exception = ex;
        } catch (SpecPendingException ex) {
          status    = BullseyeTestStatus.pending;
          exception = ex;
        } catch (Exception ex) {
          status    = BullseyeTestStatus.error;
          exception = ex;
        }
      }
    }
  }

}
