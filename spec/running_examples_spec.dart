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

class RunningExamplesSpec extends SpecDartTest {
  spec() {
    describe("Running Examples", {

      "it can run the examples in a single describe": (){
        var describe = new RunningExamplesSpec_SingleDescribe().describes[0];
        Expect.equals(4, describe.examples.length);
        describe.examples.forEach((ex) => Expect.isNull(ex.result));
        
        describe.run(); // TODO should return a result

        Expect.equals(SpecExampleResult.passed,  describe.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  describe.examples[1].result);
        Expect.equals(SpecExampleResult.error,   describe.examples[2].result);
        Expect.equals(SpecExampleResult.pending, describe.examples[3].result);
      },

      "it can run the examples in a single spec": (){
        var spec      = new RunningExamplesSpec_SingleDescribe();
        var describe1 = spec.describes[0];
        var describe2 = spec.describes[1];
        describe1.examples.forEach((ex) => Expect.isNull(ex.result));
        describe2.examples.forEach((ex) => Expect.isNull(ex.result));

        spec.run(); // TODO should return a result

        // foo
        Expect.equals(SpecExampleResult.passed,  describe1.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  describe1.examples[1].result);
        Expect.equals(SpecExampleResult.error,   describe1.examples[2].result);
        Expect.equals(SpecExampleResult.pending, describe1.examples[3].result);

        // bar
        Expect.equals(SpecExampleResult.pending, describe2.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  describe2.describes[0].describes[0].examples[0].result);
        Expect.equals(SpecExampleResult.passed,  describe2.examples[1].result);
      },

    });
  }
}
