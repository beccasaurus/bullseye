class Specs {
  static SpecFormatter formatter;

  static bool _formatterCallbacksSetup;

  static void run(List<Spec> specs) {
    _setupFormatterCallbacks();

    if (formatter == null)
      formatter = new SpecDocFormatter();

    formatter.header();
    specs.forEach((spec) => spec.run());
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
      BullseyeTestFixtureDefinition.beforeRun((spec) => Specs.formatter.beforeSpec(spec));
      BullseyeTestFixtureDefinition.afterRun((spec) => Specs.formatter.afterSpec(spec));
      SpecDescribe.beforeRun((desc) => Specs.formatter.beforeDescribe(desc));
      SpecDescribe.afterRun((desc) => Specs.formatter.afterDescribe(desc));
      SpecExample.beforeRun((ex) => Specs.formatter.beforeExample(ex));
      SpecExample.afterRun((ex) => Specs.formatter.afterExample(ex));
    }
  }
}
