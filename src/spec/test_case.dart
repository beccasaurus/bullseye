class TestCase extends Spec {

  void spec() => defineTests();

  SpecDescribe context([String subject = null, Function fn = null]) {
    describe(subject: subject, fn: fn);
  }

  SpecExample test([String name = null, Function fn = null]) {
    it(name: name, fn: fn);
  }

  void setUp([Function fn = null]) {
    before(fn: fn);
  }

  void tearDown([Function fn = null]) {
    after(fn: fn);
  }
}
