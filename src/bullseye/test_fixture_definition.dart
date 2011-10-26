class BullseyeTestFixtureDefinition extends BullseyeTestFixture {

  // Keeps track of the list of BullseyeTestFixture that are currently being defined.
  //
  // A BullseyeTestFixtureDefinition lets you simply call defineTest() and it 
  // finds the most recent BullseyeTestFixture being defined via defineNestedTestFixture 
  // (or the top-level BullseyeTestFixture, ie. this BullseyeTestFixtureDefinition) and 
  // it will add a BullseyeTest to *that* BullseyeTestFixture.
  //
  // This keeps track of those BullseyeTestFixture so we can find the one you're currently defining.
  List<BullseyeTestFixture> _testFixturesBeingDefined;

  BullseyeTestFixtureDefinition() {
    _testFixturesBeingDefined = <BullseyeTestFixture>[this];
    defineTestFixture();
  }

  String get description() {
    // TODO if description was set manually, return it, otherwise return the default.
    return defaultSubjectName;
  }

  String get defaultSubjectName() => BullseyeUtils.getClassName(this);

  void defineTestFixture(){}

  BullseyeTestFixture defineNestedTestFixture([String description = null, Function fn = null]) {
    BullseyeTestFixture testFixture = new BullseyeTestFixture(description: description, fn: fn, parent: _currentTestFixture);

    _currentTestFixture.testFixtures.add(testFixture);

    _testFixturesBeingDefined.addLast(testFixture);
    testFixture.evaluate();
    _testFixturesBeingDefined.removeLast();

    return testFixture;
  }

  BullseyeTest defineTest([String description = null, Function fn = null]) {
    BullseyeTest test = new BullseyeTest(testFixture: _currentTestFixture, description: description, fn: fn);
    _currentTestFixture.tests.add(test);
    return test;
  }

  void pending([String message = "PENDING"]) {
    throw new SpecPendingException(message);
  }

  void defineSetUp([Function fn = null]) {
    _currentTestFixture.befores.add(fn);
  }

  void defineTearDown([Function fn = null]) {
    _currentTestFixture.afters.add(fn);
  }

  BullseyeTestFixture get _currentTestFixture() => _testFixturesBeingDefined.last();

  // ------------------------------ OLD BELOW ------------------------------
  
  static final VERSION = "0.1.0"; // TODO move me!

}
