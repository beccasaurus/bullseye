class OriginalPendingTestSpec extends SpecMap_Bullseye {
  spec() {

    var spec = new PendingTestSpec_Test();

    describe("Pending tests", {

      "can be defined by calling it() without a function": (){
        var test = spec.testFixtures[0].tests[0];
        test.run();
        Expect.equals(BullseyeTestResult.pending, test.result);
      },

      "can be defined by calling pending() from within your it()": (){
        var test = spec.testFixtures[0].tests[1];
        test.run();
        Expect.equals(BullseyeTestResult.pending, test.result);
      },

      "can be defined by calling pending('message') from within your it()": (){
        var test = spec.testFixtures[0].tests[2];
        test.run();
        Expect.equals(BullseyeTestResult.pending, test.result);
        Expect.equals("my awesome message", test.pendingReason);
      }

    });
  }
}

class PendingTestSpec_Test extends Spec {
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
