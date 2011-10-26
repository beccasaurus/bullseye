class BullseyeTestFixtureDefinition extends SpecDescribe implements BullseyeTestFixtureProvider {

  // Keeps track of the list of SpecDescribe that are currently being defined.
  //
  // A BullseyeTestFixtureDefinition lets you simply call defineTest() and it 
  // finds the most recent SpecDescribe being defined via defineNestedTestFixture 
  // (or the top-level SpecDescribe, ie. this BullseyeTestFixtureDefinition) and 
  // it will add a SpecExample to *that* SpecDescribe.
  //
  // This keeps track of those SpecDescribe so we can find the one you're currently defining.
  List<SpecDescribe> _testFixturesBeingDefined;

  BullseyeTestFixtureDefinition() {
    _testFixturesBeingDefined = <SpecDescribe>[this];
    defineTestFixture();
  }

  String get subject() {
    // TODO if subject was set manually, return it, otherwise return the default.
    return defaultSubjectName;
  }

  String get defaultSubjectName() => BullseyeUtils.getClassName(this);

  Iterable<SpecDescribe> get testFixtures() => <SpecDescribe>[this];

  void defineTestFixture(){}

  SpecDescribe defineNestedTestFixture([String subject = null, Function fn = null]) {
    SpecDescribe describe = new SpecDescribe(subject: subject, fn: fn, parent: _currentTestFixture);

    _currentTestFixture.describes.add(describe);

    _testFixturesBeingDefined.addLast(describe);
    describe.evaluate();
    _testFixturesBeingDefined.removeLast();

    return describe;
  }

  SpecExample defineTest([String name = null, Function fn = null]) {
    SpecExample example = new SpecExample(describe: _currentTestFixture, name: name, fn: fn);
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

  SpecDescribe get _currentTestFixture() => _testFixturesBeingDefined.last();

  // ------------------------------ OLD BELOW ------------------------------
  
  static final VERSION = "0.1.0"; // TODO move me!

}
