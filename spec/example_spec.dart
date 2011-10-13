class ExampleSpec_Example extends Spec {
  spec() {
    describe("something", (){
      it("should pass", (){
        Expect.equals(1, 1);
      });
      it("should fail", (){
        Expect.equals(1, "Not Equal!");
      });
      it("should have an error", (){
        "".stringsDontHaveThisMethod__OhNoes();
      });
      it("should be pending");
    });
  }
}

class ExampleSpec extends SpecMap {
  spec() {

    var spec = new ExampleSpec_Example();

    describe("Running Examples", {

      "passed": (){
        var example = spec.describes[0].examples[0];
        Expect.equals("should pass", example.name);
        Expect.equals(false, example.hasBeenRun);

        example.run();

        Expect.equals(true, example.hasBeenRun);
        Expect.equals(SpecExampleResult.passed, example.result);
      },

      "failed": (){
        var example = spec.describes[0].examples[1];
        Expect.equals("should fail", example.name);
        Expect.equals(false, example.hasBeenRun);

        example.run();

        Expect.equals(true, example.hasBeenRun);
        Expect.equals(SpecExampleResult.failed, example.result);
        // check exception
      },

      "error": (){
        var example = spec.describes[0].examples[2];
        Expect.equals("should have an error", example.name);
        Expect.equals(false, example.hasBeenRun);

        example.run();

        Expect.equals(true, example.hasBeenRun);
        Expect.equals(SpecExampleResult.error, example.result);
        // check exception
      },

      "pending": (){
        var example = spec.describes[0].examples[3];
        Expect.equals("should be pending", example.name);
        Expect.equals(false, example.hasBeenRun);

        example.run();

        Expect.equals(true, example.hasBeenRun);
        Expect.equals(SpecExampleResult.pending, example.result);
      },

    });
  }
}
