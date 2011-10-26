class TestCase extends BullseyeTestFixtureDefinition {

  void defineTestFixture() => defineTests();
  void defineTests(){}

  BullseyeTestFixture context([String subject = null, Function fn = null]) {
    defineNestedTestFixture(subject: subject, fn: fn);
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

class Spec extends BullseyeTestFixtureDefinition {
  static final RegExp subjectNameReplacementPattern = const RegExp(@"Spec$");

  void defineTestFixture() => spec();
  void spec(){}

  String get defaultSubjectName() {
    var subject = super.defaultSubjectName;
    return subject.endsWith("Spec") ? subject.substring(0, subject.length - 4) : subject;
  }

  BullseyeTestFixture describe([String subject = null, Function fn = null]) {
    defineNestedTestFixture(subject: subject, fn: fn);
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
