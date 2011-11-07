class BullseyeTest extends BullseyeClosure {

  static List<Function> _beforeFunctions;
  static List<Function> _afterFunctions;
  static void beforeRun(Function callback){ _beforeFunctions.add(callback); }
  static void afterRun(Function callback){ _afterFunctions.add(callback); }

  BullseyeTest([BullseyeTestFixture parent, String description = null, Function fn = null]) : super(parent: parent, description: description, fn: fn) {
    if (_beforeFunctions == null) _beforeFunctions = new List<Function>();
    if (_afterFunctions == null)  _afterFunctions = new List<Function>();
    if (description == null) this.description = "test";
  }

  void run() {
    _beforeFunctions.forEach((fn) => fn(this));
    super.run();
    _afterFunctions.forEach((fn) => fn(this));
  }
}
