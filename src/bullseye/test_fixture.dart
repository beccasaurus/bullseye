class BullseyeTestFixture {

  static List<Function> _beforeFunctions;
  static List<Function> _afterFunctions;
  static void beforeRun(Function callback) => _beforeFunctions.add(callback);
  static void afterRun(Function callback) => _afterFunctions.add(callback);
  List<BullseyeTestFixture> testFixtures;

  List<SpecExample> tests;
  BullseyeTestFixture parent;
  String subject;
  Function fn;
  List befores;
  List afters;
  bool _evaluatedFn;
  List<BullseyeTestFixture> _parentDescribes;

  List<SpecExample> get examples() => tests; // TEMPORARY TODO while refactoring

  BullseyeTestFixture([BullseyeTestFixture parent = null, String subject = null, Function fn = null]) {
    if (_beforeFunctions == null) _beforeFunctions = new List<Function>();
    if (_afterFunctions == null)  _afterFunctions = new List<Function>();

    this.subject   = subject;
    this.fn        = fn;
    this.tests  = new List<SpecExample>();
    this.testFixtures = new List<BullseyeTestFixture>();
    this.befores   = new List();
    this.afters    = new List();
    this.parent    = parent;
  }

  void evaluate() {
    if (_evaluatedFn != true) {
      _evaluatedFn = true;
      if (fn != null) fn();
    }
  }

  List<BullseyeTestFixture> get parentDescribes() {
    if (_parentDescribes == null) {

      List<BullseyeTestFixture> tempDescribes = new List<BullseyeTestFixture>();
      BullseyeTestFixture       currentParent = parent;

      while (currentParent != null) {
        tempDescribes.add(currentParent);
        currentParent = currentParent.parent;
      }

      _parentDescribes = new List<BullseyeTestFixture>();
      var times = tempDescribes.length;
      for (int i = 0; i < times; i++)
        _parentDescribes.add(tempDescribes.removeLast());
    }   
    return _parentDescribes;
  }

  void runBefores() {
    befores.forEach((fn) => fn());
  }

  void runAfters() {
    afters.forEach((fn) => fn());
  }

  void run() {
    _beforeFunctions.forEach((fn) => fn(this));
    tests.forEach((example) {
      parentDescribes.forEach((parent) => parent.runBefores());
      runBefores();
      example.run();
      runAfters();
      parentDescribes.forEach((parent) => parent.runAfters());
    });
    testFixtures.forEach((desc) => desc.run());
    _afterFunctions.forEach((fn) => fn(this));
  }
}
