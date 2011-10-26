class SpecDocFormatter extends SpecFormatter implements SpecFormattable {

  int _testFixtureDepth;

  List<BullseyeTest> tests;

  SpecDocFormatter() {
    tests = new List<BullseyeTest>();
    _testFixtureDepth = 0;
  }

  Collection<BullseyeTest> get passedTests()  => tests.filter((ex) => ex.passed);
  Collection<BullseyeTest> get failedTests()  => tests.filter((ex) => ex.failed);
  Collection<BullseyeTest> get errorTests()   => tests.filter((ex) => ex.error);
  Collection<BullseyeTest> get pendingTests() => tests.filter((ex) => ex.pending);

  void header() {
    write("~ Spec.dart ${BullseyeTestFixtureDefinition.VERSION} ~\n");
  }

  void beforeDescribe(BullseyeTestFixture testFixture) {
    write(testFixture.description, indent: _testFixtureDepth);
    ++_testFixtureDepth;
  }

  void afterDescribe(BullseyeTestFixture testFixture) {
    --_testFixtureDepth;
  }

  void afterTest(BullseyeTest test) {
    if (tests == null)
      tests = new List<BullseyeTest>();

    tests.add(test);

    String pendingString = "";
    if (test.pending == true)
      if (test.pendingReason == null)
        pendingString = "[PENDING] ";
      else
        pendingString = "[${test.pendingReason}] ";

    write(pendingString + test.description, indent: _testFixtureDepth, color: colorForTest(test));
  }

  String colorForTest(BullseyeTest test) {
    switch (test.result) {
      case BullseyeTestResult.passed:  return "green";
      case BullseyeTestResult.failed:  return "red";
      case BullseyeTestResult.error:   return "red";
      case BullseyeTestResult.pending: return "yellow";
      default: return "white";
    }
  }

  void separator() {
    write("\n~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }

  void footer() {
    if (failedTests.length > 0 || errorTests.length > 0 || pendingTests.length > 0) separator();
    failedSummary();
    errorSummary();
    pendingSummary();
    summary();
  }

  void summary() {
    String color   = "green";
    String summary = "\n${tests.length} Tests, ${failedTests.length} Failures";
    if (errorTests.length > 0) {
      summary += ", ${errorTests.length} Errors";
      color = "red";
    }
    if (pendingTests.length > 0) {
      summary += ", ${pendingTests.length} Pending";
      if (color == "green")
        color = "yellow";
    }
    write(summary, color: color);
  }

  void failedSummary() {
    if (failedTests.length > 0) {
      write("\nFailures:");
      failedTests.forEach((test) {
        write("");
        write("${test.testFixture.description} ${test.description}", indent: 1, color: colorForTest(test));
        write("Exception: ${test.exception}", indent: 2);
      });
    }
  }

  void errorSummary() {
    if (errorTests.length > 0) {
      write("\nErrors:");
      errorTests.forEach((test) {
        write("");
        write("${test.testFixture.description} ${test.description}", indent: 1, color: colorForTest(test));
        write("Exception: ${test.exception}", indent: 2, color: colorForTest(test));
      });
    }
  }

  void pendingSummary() {
    if (pendingTests.length > 0) {
      write("\nPending:\n");
      pendingTests.forEach((test) {
        String pendingReason = (test.pendingReason != null) ? " [${test.pendingReason}]" : "";
        write("${test.testFixture.description} ${test.description}${pendingReason}", indent: 1, color: colorForTest(test));
      });
    }
  }
}
