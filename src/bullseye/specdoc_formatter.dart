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
    write("~ Bullseye ${BullseyeTestFixtureDefinition.VERSION} ~\n");
  }

  void beforeDescribe(BullseyeTestFixture testFixture) {
    write(testFixture.description, indent: _testFixtureDepth);
    ++_testFixtureDepth;
  }

  void afterDescribe(BullseyeTestFixture testFixture) {
    --_testFixtureDepth;
    if (_testFixtureDepth == 0)
      writeNewline();
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
    switch (test.status) {
      case BullseyeTestStatus.passed:  return "green";
      case BullseyeTestStatus.failed:  return "red";
      case BullseyeTestStatus.error:   return "red";
      case BullseyeTestStatus.pending: return "yellow";
      default: return "white";
    }
  }

  void separator() {
    write("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
  }

  void footer() {
    if (shouldPrintSeparator) separator();
    failedSummary();
    errorSummary();
    pendingSummary();
    summary();
  }

  bool get shouldPrintSeparator() => (failedTests.length > 0 || errorTests.length > 0 || pendingTests.length > 0);

  void summary() {
    String color   = "green";
    String summary = "${tests.length} Tests, ${failedTests.length} Failures";
    if (shouldPrintSeparator)
      summary = "\n$summary";
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
        writeNewline();
        write(test.fullDescription, indent: 1, color: colorForTest(test));
        write("Exception: ${test.exception}", indent: 2);
        write("StackTrace:\n${test.stackTrace}", indent: 2);
      });
    }
  }

  void errorSummary() {
    if (errorTests.length > 0) {
      write("\nErrors:");
      errorTests.forEach((test) {
        writeNewline();
        write(test.fullDescription, indent: 1, color: colorForTest(test));
        write("Exception: ${test.exception}", indent: 2, color: colorForTest(test));
        write("StackTrace:\n${test.stackTrace}", indent: 2);
      });
    }
  }

  void pendingSummary() {
    if (pendingTests.length > 0) {
      write("\nPending:\n");
      pendingTests.forEach((test) {
        String pendingReason = (test.pendingReason != null) ? " [${test.pendingReason}]" : "";
        write("${test.fullDescription}${pendingReason}", indent: 1, color: colorForTest(test));
      });
    }
  }
}
