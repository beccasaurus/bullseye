// Spec.dart's default formatter.
//
// SpecDocFormatter prints out each describe and its examples, indented 
// to show nesting and colored based on the result of running each example.
class SpecDocFormatter extends SpecFormatter implements SpecFormattable {

  int _describeDepth;

  // A list of all of the examples that have been run 
  // through this formatter so far.
  List<SpecExample> examples;

  SpecDocFormatter() {
    examples = new List<SpecExample>();
    _describeDepth = 0;
  }

  Collection<SpecExample> get passedExamples()  => examples.filter((ex) => ex.passed);
  Collection<SpecExample> get failedExamples()  => examples.filter((ex) => ex.failed);
  Collection<SpecExample> get errorExamples()   => examples.filter((ex) => ex.error);
  Collection<SpecExample> get pendingExamples() => examples.filter((ex) => ex.pending);

  // Prints a header showing the current version of Spec.dart
  void header() {
    write("~ Spec.dart ${Spec.VERSION} ~\n");
  }

  // Print out the name of the describe that we're about 
  // to run examples for.
  void beforeDescribe(SpecDescribe describe) {
    write(describe.subject, indent: _describeDepth);
    ++_describeDepth;
  }

  void afterDescribe(SpecDescribe describe) {
    --_describeDepth;
  }

  // Print out the name of the example that was just run.
  // If passes, the output will be green.
  // If pending, the output will be yellow and will show the pending reason, if given.
  // If failed or an error occurred, the output will be red.
  void afterExample(SpecExample example) {
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

  // Given a SpecExample, this returns the the color that this 
  // example should be outputted as, eg. "red" for failing examples.
  String colorForExample(SpecExample example) {
    switch (example.result) {
      case SpecExampleResult.passed:  return "green";
      case SpecExampleResult.failed:  return "red";
      case SpecExampleResult.error:   return "red";
      case SpecExampleResult.pending: return "yellow";
      default: return "white";
    }
  }

  void separator() {
    write("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }

  void footer() {
    if (failedExamples.length > 0 || errorExamples.length > 0 || pendingExamples.length > 0) separator();
    failedSummary();
    errorSummary();
    pendingSummary();
    summary();
  }

  void summary() {
    String color   = "green";
    String summary = "\n${examples.length} Examples, ${failedExamples.length} Failures";
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

  void failedSummary() {
    if (failedExamples.length > 0) {
      write("\nFailures:");
      failedExamples.forEach((example) {
        write("");
        write("${example.describe.subject} ${example.name}", indent: 1, color: colorForExample(example));
        write("Exception: ${example.exception}", indent: 2);
      });
    }
  }

  void errorSummary() {
    if (errorExamples.length > 0) {
      write("\nErrors:");
      errorExamples.forEach((example) {
        write("");
        write("${example.describe.subject} ${example.name}", indent: 1, color: colorForExample(example));
        write("Exception: ${example.exception}", indent: 2, color: colorForExample(example));
      });
    }
  }

  void pendingSummary() {
    if (pendingExamples.length > 0) {
      write("\nPending:\n");
      pendingExamples.forEach((example) {
        String pendingReason = (example.pendingReason != null) ? " [${example.pendingReason}]" : null;
        write("${example.describe.subject} ${example.name}${pendingReason}", indent: 1, color: colorForExample(example));
      });
    }
  }
}
