class RunHooksSpec_Example1 extends Spec {
  spec() {
    describe("foo", (){
      it("foo");
    });
    describe("bar", (){
      it("bar");
    });
  }
}
class RunHooksSpec_Example2 extends Spec {
  spec() {
    describe("baz", (){
      it("baz");
    });
  }
}

class RunHooksSpec extends SpecDartTest {
  var hookData;

  spec() {
    hookData = { "spec:before": [], "spec:after": [], 
                 "desc:before": [], "desc:after": [],
                 "ex:before":   [], "ex:after":   [] };

    Spec.beforeRun((spec) => hookData["spec:before"].add(spec));
    Spec.afterRun((spec) => hookData["spec:after"].add(spec));
    SpecDescribe.beforeRun((desc) => hookData["desc:before"].add(desc));
    SpecDescribe.afterRun((desc) => hookData["desc:after"].add(desc));
    SpecExample.beforeRun((ex) => hookData["ex:before"].add(ex));
    SpecExample.afterRun((ex) => hookData["ex:after"].add(ex));
    
    new RunHooksSpec_Example1().run();
    new RunHooksSpec_Example2().run();

    describe("Global run() hooks", {

      "can hook into Spec.beforeRun()": (){
        Expect.equals(2, hookData["spec:before"].length);
        Expect.isTrue(hookData["spec:before"][0] is RunHooksSpec_Example1);
        Expect.isTrue(hookData["spec:before"][1] is RunHooksSpec_Example2);
      },

      "can hook into Spec.afterRun()": (){
        Expect.equals(2, hookData["spec:after"].length);
        Expect.isTrue(hookData["spec:after"][0] is RunHooksSpec_Example1);
        Expect.isTrue(hookData["spec:after"][1] is RunHooksSpec_Example2);
      },

      "can hook into SpecDescribe.beforeRun()": (){
        Expect.equals(3, hookData["desc:before"].length);
        Expect.equals("foo", hookData["desc:before"][0].subject);
        Expect.equals("bar", hookData["desc:before"][1].subject);
        Expect.equals("baz", hookData["desc:before"][2].subject);
      },

      "can hook into SpecDescribe.afterRun()": (){
        Expect.equals(3, hookData["desc:after"].length);
        Expect.equals("foo", hookData["desc:after"][0].subject);
        Expect.equals("bar", hookData["desc:after"][1].subject);
        Expect.equals("baz", hookData["desc:after"][2].subject);
      },

      "can hook into SpecExample.beforeRun()": (){
        Expect.equals(3, hookData["ex:before"].length);
        Expect.equals("foo", hookData["ex:before"][0].name);
        Expect.equals("bar", hookData["ex:before"][1].name);
        Expect.equals("baz", hookData["ex:before"][2].name);
      },

      "can hook into SpecExample.afterRun()": (){
        Expect.equals(3, hookData["ex:after"].length);
        Expect.equals("foo", hookData["ex:after"][0].name);
        Expect.equals("bar", hookData["ex:after"][1].name);
        Expect.equals("baz", hookData["ex:after"][2].name);
      }

    });
  }
}
