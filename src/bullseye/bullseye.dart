class Bullseye {

  static SpecFormatter formatter;

  static bool _formatterCallbacksSetup;

  static void run(Iterable<BullseyeTestFixture> fixtures) {
    _setupFormatterCallbacks();

    if (formatter == null)
      formatter = new SpecDocFormatter();

    formatter.header();
    fixtures.forEach((fixture) => fixture.run());
    formatter.footer();
  }

  static void throwExceptions() {
    BullseyeTest.throwExceptions = true;
  }

  static void dontThrowExceptions() {
    BullseyeTest.throwExceptions = false;
  }

  static _setupFormatterCallbacks() {
    if (_formatterCallbacksSetup != true) {
      _formatterCallbacksSetup = true;
      BullseyeTestFixture.beforeRun((desc) => Bullseye.formatter.beforeDescribe(desc));
      BullseyeTestFixture.afterRun((desc) => Bullseye.formatter.afterDescribe(desc));
      BullseyeTest.beforeRun((ex) => Bullseye.formatter.beforeTest(ex));
      BullseyeTest.afterRun((ex) => Bullseye.formatter.afterTest(ex));
    }
  }
}
