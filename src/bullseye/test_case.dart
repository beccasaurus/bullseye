class TestCase extends BullseyeTestFixtureDefinition {

  void defineTestFixture() => defineTests();
  void defineTests(){}

  BullseyeTestFixture context([String subject = null, Function fn = null]) {
    defineNestedTestFixture(subject: subject, fn: fn);
  }

  BullseyeTest test([String name = null, Function fn = null]) {
    defineTest(name: name, fn: fn);
  }

  void setUp([Function fn = null]) {
    defineSetUp(fn: fn);
  }

  void tearDown([Function fn = null]) {
    defineTearDown(fn: fn);
  }
}
