class Specs {
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
    SpecExample.throwExceptions = true;
  }

  static void dontThrowExceptions() {
    SpecExample.throwExceptions = false;
  }

  static _setupFormatterCallbacks() {
    if (_formatterCallbacksSetup != true) {
      _formatterCallbacksSetup = true;
      BullseyeTestFixture.beforeRun((desc) => Specs.formatter.beforeDescribe(desc));
      BullseyeTestFixture.afterRun((desc) => Specs.formatter.afterDescribe(desc));
      SpecExample.beforeRun((ex) => Specs.formatter.beforeExample(ex));
      SpecExample.afterRun((ex) => Specs.formatter.afterExample(ex));
    }
  }
}
