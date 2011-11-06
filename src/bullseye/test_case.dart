class TestCase extends BullseyeTestFixtureDefinition {

  void defineTestFixture() => defineTests();
  void defineTests(){}

  BullseyeTestFixture context([String description = null, Function fn = null]) {
    defineNestedTestFixture(description: description, fn: fn);
  }

  BullseyeTest test([String description = null, Function fn = null]) {
    defineTest(description: description, fn: fn);
  }

  // TODO add coverage - specifically for Classic DSL
  List<BullseyeTest> tests(Iterable<Function> functions) {
    List<BullseyeTest> allTests;
    for (Function fn in functions)
      allTests.add(test(fn: fn));
    return allTests;
  }

  void setUp([Function fn = null]) {
    defineSetUp(fn: fn);
  }

  void tearDown([Function fn = null]) {
    defineTearDown(fn: fn);
  }
}
