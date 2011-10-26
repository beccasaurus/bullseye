class Spec extends BullseyeTestFixtureDefinition {
  static final RegExp subjectNameReplacementPattern = const RegExp(@"Spec$");

  void defineTestFixture() => spec();
  void spec(){}

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

  String get defaultSubjectName() {
    var subject = super.defaultSubjectName;
    return subject.endsWith("Spec") ? subject.substring(0, subject.length - 4) : subject;
  }
}
