interface BullseyeTestContextProvider {
  //Iterable<BullseyeTestContext> get testContexts();
  Iterable<SpecDescribe> get testContexts();
}

class TestCase extends BullseyeTestContextDefinition implements BullseyeTestContextProvider {

  void defineTestContext() => defineTests();
  void defineTests(){}

  SpecDescribe context([String subject = null, Function fn = null]) {
    defineNestedTestContext(subject: subject, fn: fn);
  }

  SpecExample test([String name = null, Function fn = null]) {
    defineTest(name: name, fn: fn);
  }

  void setUp([Function fn = null]) {
    defineSetUp(fn: fn);
  }

  void tearDown([Function fn = null]) {
    defineTearDown(fn: fn);
  }
}

class Spec extends BullseyeTestContextDefinition implements BullseyeTestContextProvider {

  void defineTestContext() => spec();
  void spec(){}

  SpecDescribe describe([String subject = null, Function fn = null]) {
    defineNestedTestContext(subject: subject, fn: fn);
  }

  SpecExample it([String name = null, Function fn = null]) {
    defineTest(name: name, fn: fn);
  }

  void before([Function fn = null]) {
    defineSetUp(fn: fn);
  }

  void after([Function fn = null]) {
    defineTearDown(fn: fn);
  }
}
