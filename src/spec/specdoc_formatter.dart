class SpecDocFormatter extends SpecFormatter {
  List<SpecExample> examples;

  header() {
    write("~ Spec.dart ${Spec.VERSION} ~\n");
  }

  beforeDescribe(describe) {
    write(describe.subject);
  }

  beforeExample(example) {
    if (examples == null)
      examples = new List<SpecExample>();
    examples.add(example);
    write(example.name, indent: 1);
  }

  footer() {
    summary();
  }

  get passedExamples()  => examples.filter((ex) => ex.passed);
  get failedExamples()  => examples.filter((ex) => ex.failed);
  get errorExamples()   => examples.filter((ex) => ex.error);
  get pendingExamples() => examples.filter((ex) => ex.pending);

  summary() {
    var summary = "\n${examples.length} Examples";
    if (failedExamples.length > 0)
      summary += ", ${failedExamples.length} Failures";
    if (errorExamples.length > 0)
      summary += ", ${errorExamples.length} Errors";
    if (pendingExamples.length > 0)
      summary += ", ${pendingExamples.length} Pending";
    write(summary);
  }
}
