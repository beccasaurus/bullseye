class BullseyeTestFixtureDefinition extends BullseyeTestFixture {

  // Keeps track of the list of BullseyeTestFixture that are currently being defined.
  //
  // A BullseyeTestFixtureDefinition lets you simply call defineTest() and it 
  // finds the most recent BullseyeTestFixture being defined via defineNestedTestFixture 
  // (or the top-level BullseyeTestFixture, ie. this BullseyeTestFixtureDefinition) and 
  // it will add a SpecExample to *that* BullseyeTestFixture.
  //
  // This keeps track of those BullseyeTestFixture so we can find the one you're currently defining.
  List<BullseyeTestFixture> _testFixturesBeingDefined;

  BullseyeTestFixtureDefinition() {
    _testFixturesBeingDefined = <BullseyeTestFixture>[this];
    defineTestFixture();
  }

  String get subject() {
    // TODO if subject was set manually, return it, otherwise return the default.
    return defaultSubjectName;
  }

  String get defaultSubjectName() => BullseyeUtils.getClassName(this);

  void defineTestFixture(){}

  BullseyeTestFixture defineNestedTestFixture([String subject = null, Function fn = null]) {
    BullseyeTestFixture testFixture = new BullseyeTestFixture(subject: subject, fn: fn, parent: _currentTestFixture);

    _currentTestFixture.testFixtures.add(testFixture);

    _testFixturesBeingDefined.addLast(testFixture);
    testFixture.evaluate();
    _testFixturesBeingDefined.removeLast();

    return testFixture;
  }

  SpecExample defineTest([String name = null, Function fn = null]) {
    SpecExample example = new SpecExample(testFixture: _currentTestFixture, name: name, fn: fn);
    _currentTestFixture.examples.add(example);
    return example;
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
