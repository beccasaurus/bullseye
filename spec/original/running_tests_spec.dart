class OriginalRunningTestsSpec extends SpecMap_Bullseye {
  spec() {
    describe("Running Tests", {

      "it can run the tests in a single testFixture": (){
        var testFixture = new RunningTestsSpec_SingleDescribe().testFixtures[0];
        Expect.equals(4, testFixture.tests.length);
        
        testFixture.run(); // TODO should return a status

        Expect.equals(BullseyeTestStatus.passed,  testFixture.tests[0].status);
        Expect.equals(BullseyeTestStatus.failed,  testFixture.tests[1].status);
        Expect.equals(BullseyeTestStatus.error,   testFixture.tests[2].status);
        Expect.equals(BullseyeTestStatus.pending, testFixture.tests[3].status);
      },

      "it can run the tests in a single spec": (){
        var spec      = new RunningTestsSpec_SingleDescribe();
        var testFixture1 = spec.testFixtures[0];
        var testFixture2 = spec.testFixtures[1];

        spec.run(); // TODO should return a status

        // foo
        Expect.equals(BullseyeTestStatus.passed,  testFixture1.tests[0].status);
        Expect.equals(BullseyeTestStatus.failed,  testFixture1.tests[1].status);
        Expect.equals(BullseyeTestStatus.error,   testFixture1.tests[2].status);
        Expect.equals(BullseyeTestStatus.pending, testFixture1.tests[3].status);

        // bar
        Expect.equals(BullseyeTestStatus.pending, testFixture2.tests[0].status);
        Expect.equals(BullseyeTestStatus.failed,  testFixture2.testFixtures[0].testFixtures[0].tests[0].status);
        Expect.equals(BullseyeTestStatus.passed,  testFixture2.tests[1].status);
      },

    });
  }
}

class RunningTestsSpec_SingleDescribe extends BullseyeSpec {
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
