class TestCase extends BullseyeTestFixtureDefinition {

  void defineTestFixture() { 
    // defineTests() can optionally return an Iterable<Function>.
    // If functions are returned, we call test() to add each of them as an unnamed test.
    var testFunctions = defineTests();
    if (testFunctions is Iterable<Function>)
      for (Function fn in testFunctions)
        test(fn: fn);
  }

  Iterable<Function> defineTests(){}

  BullseyeTestFixture context([String description = null, Function fn = null]) {
    defineNestedTestFixture(description: description, fn: fn);
  }

  BullseyeTest test([String description = null, Function fn = null]) {
    defineTest(description: description, fn: fn);
  }

  void setUp([Function fn = null]) {
    defineSetUp(fn: fn);
  }

  void tearDown([Function fn = null]) {
    defineTearDown(fn: fn);
  }
}
