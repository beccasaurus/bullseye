class RunHooksSpec extends SpecMap_Bullseye {
  var hookData;

  spec() {
    hookData = { "desc:before": [], "desc:after": [], "ex:before": [], "ex:after": [] };

    BullseyeTestFixture.beforeRun((desc) => hookData["desc:before"].add(desc));
    BullseyeTestFixture.afterRun((desc) => hookData["desc:after"].add(desc));
    BullseyeTest.beforeRun((ex) => hookData["ex:before"].add(ex));
    BullseyeTest.afterRun((ex) => hookData["ex:after"].add(ex));
    
    new RunHooksSpec_Test1().run();
    new RunHooksSpec_Test2().run();

    describe("Global run() hooks", {

      "can hook into BullseyeTestFixture.beforeRun()": (){
        Expect.equals(5,                       hookData["desc:before"].length);
        Expect.equals("RunHooksSpec_Test1", hookData["desc:before"][0].subject);
        Expect.equals("foo",                   hookData["desc:before"][1].subject);
        Expect.equals("bar",                   hookData["desc:before"][2].subject);
        Expect.equals("RunHooksSpec_Test2", hookData["desc:before"][3].subject);
        Expect.equals("baz",                   hookData["desc:before"][4].subject);
      },

      "can hook into BullseyeTestFixture.afterRun()": (){
        Expect.equals(5,                       hookData["desc:after"].length);
        Expect.equals("foo",                   hookData["desc:after"][0].subject);
        Expect.equals("bar",                   hookData["desc:after"][1].subject);
        Expect.equals("RunHooksSpec_Test1", hookData["desc:after"][2].subject);
        Expect.equals("baz",                   hookData["desc:after"][3].subject);
        Expect.equals("RunHooksSpec_Test2", hookData["desc:after"][4].subject);
      },

      "can hook into BullseyeTest.beforeRun()": (){
        Expect.equals(3, hookData["ex:before"].length);
        Expect.equals("foo", hookData["ex:before"][0].name);
        Expect.equals("bar", hookData["ex:before"][1].name);
        Expect.equals("baz", hookData["ex:before"][2].name);
      },

      "can hook into BullseyeTest.afterRun()": (){
        Expect.equals(3, hookData["ex:after"].length);
        Expect.equals("foo", hookData["ex:after"][0].name);
        Expect.equals("bar", hookData["ex:after"][1].name);
        Expect.equals("baz", hookData["ex:after"][2].name);
      }

    });
  }
}

class RunHooksSpec_Test1 extends Spec {
  spec() {
    describe("foo", (){
      it("foo");
    });
    describe("bar", (){
      it("bar");
    });
  }
}
class RunHooksSpec_Test2 extends Spec {
  spec() {
    describe("baz", (){
      it("baz");
    });
  }
}
