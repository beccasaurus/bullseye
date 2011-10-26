// This is useful so we don't have to care what type of object(s) you 
// pass to a runner, it just takes test suites and knows howto get its 
// fixtures.  You could provide the fixtures directly, but ... meh?  Might remove this?
interface BullseyeTestSuite {
  Iterable<SpecDescribe> get testFixtures();
}

class TestCase extends BullseyeTestFixtureDefinition implements BullseyeTestSuite {

  void defineTestFixture() => defineTests();
  void defineTests(){}

  SpecDescribe context([String subject = null, Function fn = null]) {
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

class Spec extends BullseyeTestFixtureDefinition implements BullseyeTestSuite {
  static final RegExp subjectNameReplacementPattern = const RegExp(@"Spec$");

  void defineTestFixture() => spec();
  void spec(){}

  String get defaultSubjectName() {
    var subject = super.defaultSubjectName;
    return subject.endsWith("Spec") ? subject.substring(0, subject.length - 4) : subject;
  }

  SpecDescribe describe([String subject = null, Function fn = null]) {
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
