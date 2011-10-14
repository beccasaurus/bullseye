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

    write(pendingString + example.name, indent: _describeDepth, color: colorForExample(example));
  }

  colorForExample(var example) {
    switch (example.result) {
      case SpecExampleResult.passed:  return "green";
      case SpecExampleResult.failed:  return "red";
      case SpecExampleResult.error:   return "red";
      case SpecExampleResult.pending: return "yellow";
      default: return "white";
    }
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
    var color = "green";
    var summary = "\n${examples.length} Examples, ${failedExamples.length} Failures";
    if (errorExamples.length > 0) {
      summary += ", ${errorExamples.length} Errors";
      color = "red";
    }
    if (pendingExamples.length > 0) {
      summary += ", ${pendingExamples.length} Pending";
      if (color == "green")
        color = "yellow";
    }
    write(summary, color: color);
  }

  failedSummary() {
    if (failedExamples.length > 0) {
      write("\nFailures:");
      failedExamples.forEach((example) {
        write("");
        write("${example.describe.subject} ${example.name}", indent: 1, color: colorForExample(example));
        write("Exception: ${example.exception}", indent: 2);
      });
    }
  }

  errorSummary() {
    if (errorExamples.length > 0) {
      write("\nErrors:");
      errorExamples.forEach((example) {
        write("");
        write("${example.describe.subject} ${example.name}", indent: 1, color: colorForExample(example));
        write("Exception: ${example.exception}", indent: 2, color: colorForExample(example));
      });
    }
  }

  pendingSummary() {
    if (pendingExamples.length > 0) {
      write("\nPending:\n");
      pendingExamples.forEach((example) {
        String pendingReason = (example.pendingReason != null) ? " [${example.pendingReason}]" : null;
        write("${example.describe.subject} ${example.name}${pendingReason}", indent: 1, color: colorForExample(example));
      });
    }
  }
}
