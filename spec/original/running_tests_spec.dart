class OriginalRunningTestsSpec extends SpecMap_Bullseye {
  spec() {
    describe("Running Tests", {

      "it can run the tests in a single testFixture": (){
        var testFixture = new RunningTestsSpec_SingleDescribe().testFixtures[0];
        Expect.equals(4, testFixture.tests.length);
        testFixture.tests.forEach((ex) => Expect.isNull(ex.result));
        
        testFixture.run(); // TODO should return a result

        Expect.equals(BullseyeTestResult.passed,  testFixture.tests[0].result);
        Expect.equals(BullseyeTestResult.failed,  testFixture.tests[1].result);
        Expect.equals(BullseyeTestResult.error,   testFixture.tests[2].result);
        Expect.equals(BullseyeTestResult.pending, testFixture.tests[3].result);
      },

      "it can run the tests in a single spec": (){
        var spec      = new RunningTestsSpec_SingleDescribe();
        var testFixture1 = spec.testFixtures[0];
        var testFixture2 = spec.testFixtures[1];
        testFixture1.tests.forEach((ex) => Expect.isNull(ex.result));
        testFixture2.tests.forEach((ex) => Expect.isNull(ex.result));

        spec.run(); // TODO should return a result

        // foo
        Expect.equals(BullseyeTestResult.passed,  testFixture1.tests[0].result);
        Expect.equals(BullseyeTestResult.failed,  testFixture1.tests[1].result);
        Expect.equals(BullseyeTestResult.error,   testFixture1.tests[2].result);
        Expect.equals(BullseyeTestResult.pending, testFixture1.tests[3].result);

        // bar
        Expect.equals(BullseyeTestResult.pending, testFixture2.tests[0].result);
        Expect.equals(BullseyeTestResult.failed,  testFixture2.testFixtures[0].testFixtures[0].tests[0].result);
        Expect.equals(BullseyeTestResult.passed,  testFixture2.tests[1].result);
      },

    });
  }
}

class RunningTestsSpec_SingleDescribe extends Spec {
  spec() {
    describe("foo", (){
      it("passes", (){});
      it("fails", (){ Expect.isTrue(false); });
      it("blows up", (){ "".noMethodSoThisGoBoom(); });
      it("pending");
    });
    describe("bar", (){
      it("pending");
      describe("inner", (){
        describe("inner-inner", (){
          it("fails", (){ Expect.isTrue(false); });
        });
      });
      it("passed", (){});
    });
  }
}
