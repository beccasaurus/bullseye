class Spec extends BullseyeTestFixtureDefinition {
  static final RegExp descriptionNameReplacementPattern = const RegExp(@"Spec$");

  void defineTestFixture(){ spec(); }
  void spec(){}

  BullseyeTestFixture describe([String description = null, Function fn = null]) {
    defineNestedTestFixture(description: description, fn: fn);
  }

  BullseyeTest it([String description = null, Function fn = null]) {
    defineTest(description: description, fn: fn);
  }

  void before([Function fn = null]) {
    defineSetUp(fn: fn);
  }

  void after([Function fn = null]) {
    defineTearDown(fn: fn);
  }

  String get defaultSubjectName() {
    var description = super.defaultSubjectName;
    return description.endsWith("Spec") ? description.substring(0, description.length - 4) : description;
  }
}
