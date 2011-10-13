class Specs {
  static SpecFormatter formatter;

  static void run(var specs) {
    _setupFormatterCallbacks();

    if (formatter == null)
      formatter = new SpecDocFormatter();

    if (specs is Spec)
      specs = [specs];

    formatter.header();
    specs.forEach((spec) => spec.run());
    formatter.footer();
  }

  static _setupFormatterCallbacks() {
    Spec.beforeRun((spec) => Specs.formatter.beforeSpec(spec));
    Spec.afterRun((spec) => Specs.formatter.afterSpec(spec));
    SpecDescribe.beforeRun((desc) => Specs.formatter.beforeDescribe(desc));
    SpecDescribe.afterRun((desc) => Specs.formatter.afterDescribe(desc));
    SpecExample.beforeRun((ex) => Specs.formatter.beforeExample(ex));
    SpecExample.afterRun((ex) => Specs.formatter.afterExample(ex));
  }
}
