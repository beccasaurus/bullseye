class Bullseye {

  static BullseyeSpecFormatter formatter;

  static bool _formatterCallbacksSetup;

  static void run(Iterable<BullseyeTestFixture> fixtures) {
    _setupFormatterCallbacks();

    if (formatter == null)
      formatter = new BullseyeSpecDocFormatter();

    formatter.header();
    for (BullseyeTestFixture fixture in fixtures) fixture.run();
    formatter.footer();
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
