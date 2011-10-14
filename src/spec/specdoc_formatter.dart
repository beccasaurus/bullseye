// TODO add typing

class SpecDocFormatter extends SpecFormatter {
  List<SpecExample> examples;

  header() {
    write("~ Spec.dart ${Spec.VERSION} ~\n");
  }

  beforeDescribe(describe) {
    if (examples != null) write(""); // not the first describe
    write(describe.subject);
  }

  afterExample(example) {
    if (examples == null)
      examples = new List<SpecExample>();

    examples.add(example);

    if (example.pending == true)
      write('[PENDING] ' + example.name, indent: 1);
    else
      write(example.name, indent: 1);
  }

  separator() {
    write("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }

  footer() {
    if (failedExamples.length > 0 || errorExamples.length > 0 || pendingExamples.length > 0)
      separator();
    failedSummary();
    errorSummary();
    pendingSummary();
    summary();
  }

  get passedExamples()  => examples.filter((ex) => ex.passed);
  get failedExamples()  => examples.filter((ex) => ex.failed);
  get errorExamples()   => examples.filter((ex) => ex.error);
  get pendingExamples() => examples.filter((ex) => ex.pending);

  summary() {
    var summary = "\n${examples.length} Examples, ${failedExamples.length} Failures";
    if (errorExamples.length > 0)
      summary += ", ${errorExamples.length} Errors";
    if (pendingExamples.length > 0)
      summary += ", ${pendingExamples.length} Pending";
    write(summary);
  }

  failedSummary() {
    if (failedExamples.length > 0) {
      write("\nFailures:");
      failedExamples.forEach((example) {
        write("");
        write("${example.describe.subject} ${example.name}", indent: 1);
        write("Exception: ${example.exception}", indent: 2);
      });
    }
  }

  errorSummary() {
    if (errorExamples.length > 0) {
      write("\nErrors:");
      errorExamples.forEach((example) {
        write("");
        write("${example.describe.subject} ${example.name}", indent: 1);
        write("Exception: ${example.exception}", indent: 2);
      });
    }
  }

  pendingSummary() {
    if (pendingExamples.length > 0) {
      write("\nPending:");
      pendingExamples.forEach((example) {
        write("${example.describe.subject} ${example.name}", indent: 1);
      });
    }
  }
}
