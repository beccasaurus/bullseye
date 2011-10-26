class RunningExamplesSpec extends SpecMap_Bullseye {
  spec() {
    describe("Running Examples", {

      "it can run the examples in a single testFixture": (){
        var testFixture = new RunningExamplesSpec_SingleDescribe().testFixtures[0];
        Expect.equals(4, testFixture.examples.length);
        testFixture.examples.forEach((ex) => Expect.isNull(ex.result));
        
        testFixture.run(); // TODO should return a result

        Expect.equals(SpecExampleResult.passed,  testFixture.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  testFixture.examples[1].result);
        Expect.equals(SpecExampleResult.error,   testFixture.examples[2].result);
        Expect.equals(SpecExampleResult.pending, testFixture.examples[3].result);
      },

      "it can run the examples in a single spec": (){
        var spec      = new RunningExamplesSpec_SingleDescribe();
        var testFixture1 = spec.testFixtures[0];
        var testFixture2 = spec.testFixtures[1];
        testFixture1.examples.forEach((ex) => Expect.isNull(ex.result));
        testFixture2.examples.forEach((ex) => Expect.isNull(ex.result));

        spec.run(); // TODO should return a result

        // foo
        Expect.equals(SpecExampleResult.passed,  testFixture1.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  testFixture1.examples[1].result);
        Expect.equals(SpecExampleResult.error,   testFixture1.examples[2].result);
        Expect.equals(SpecExampleResult.pending, testFixture1.examples[3].result);

        // bar
        Expect.equals(SpecExampleResult.pending, testFixture2.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  testFixture2.testFixtures[0].testFixtures[0].examples[0].result);
        Expect.equals(SpecExampleResult.passed,  testFixture2.examples[1].result);
      },

    });
  }
}

class RunningExamplesSpec_SingleDescribe extends Spec {
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
