class PendingExampleSpec extends SpecMap_Bullseye {
  spec() {

    var spec = new PendingExampleSpec_Example();

    describe("Pending examples", {

      "can be defined by calling it() without a function": (){
        var example = spec.testFixtures[0].examples[0];
        example.run();
        Expect.equals(SpecExampleResult.pending, example.result);
      },

      "can be defined by calling pending() from within your it()": (){
        var example = spec.testFixtures[0].examples[1];
        example.run();
        Expect.equals(SpecExampleResult.pending, example.result);
      },

      "can be defined by calling pending('message') from within your it()": (){
        var example = spec.testFixtures[0].examples[2];
        example.run();
        Expect.equals(SpecExampleResult.pending, example.result);
        Expect.equals("my awesome message", example.pendingReason);
      }

    });
  }
}

class PendingExampleSpec_Example extends Spec {
  spec() {
    describe("foo", (){
      it("pending because no function");
      it("pending because called pending()", (){
        pending();
        "".thisWouldBlowUpBecauseThisMethodDoesntExist();
      });
      it("pending because called pending('message')", (){
        pending("my awesome message");
        "".thisWouldBlowUpBecauseThisMethodDoesntExist();
      });
    });
  }
}
