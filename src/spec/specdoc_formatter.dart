// TODO add typing!  and clean up!
class SpecDocFormatter extends SpecFormatter {
  List<SpecExample> examples;
  
  var _describeDepth;

  SpecDocFormatter() {
    examples = new List<SpecExample>();
    _describeDepth = 0;
  }

  header() {
    write("~ Spec.dart ${Spec.VERSION} ~\n");
  }

  beforeDescribe(describe) {
    write(describe.subject, indent: _describeDepth);
    ++_describeDepth;
  }

  afterDescribe(describe) {
    --_describeDepth;
  }

  afterExample(example) {
    if (examples == null)
      examples = new List<SpecExample>();

    examples.add(example);

    String pendingString = "";
    if (example.pending == true)
      if (example.pendingReason == null)
        pendingString = "[PENDING] ";
      else
        pendingString = "[${example.pendingReason}] ";

    write(pendingString + example.name, indent: _describeDepth);
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
      write("\nPending:\n");
      pendingExamples.forEach((example) {
        write("${example.describe.subject} ${example.name}", indent: 1);
      });
    }
  }
}
