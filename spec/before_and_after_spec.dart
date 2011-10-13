class BeforeAndAfterSpec_With1Before extends Spec {
  var text;

  spec() {
    describe("foo", (){
      before(() => text = "Initial Text");

      it("checks initial text and then changes text", (){
        Expect.equals("Initial Text", text);
        text = "Changed!";
        Expect.equals("Changed!", text);
      });

      it("checks initial text and then also changes text", (){
        Expect.equals("Initial Text", text);
        text = "Changed Again!";
        Expect.equals("Changed Again!", text);
      });
    });
  }
}

class BeforeAndAfterSpec_With2Befores extends Spec {
  var text = "";

  spec() {
    describe("foo", (){
      before(() => text += "first");
      before(() => text += "second");

      it("text should be 'firstsecond'", (){
        Expect.equals("firstsecond", text);
      });
    });
  }
}

class BeforeAndAfterSpec_WithNestedDescribes extends Spec {
  // Using fields is problematic because you must 
  // explicitly set their defaults in a before() 
  // in every describe in your spec.
  //
  // See setup() for defining an instance method 
  // that is run before every example in a spec.
  var text = "";

  spec() {
    describe("first", (){
      before(() => text = "");
      it("first 1", () => Expect.equals("first", text));
      before(() => text += "first");
      it("first 2", () => Expect.equals("first", text));
      describe("inner", (){
        it("inner", () => Expect.equals("firstinner", text));
        describe("innermost", (){
          before(() => text += "innermost");
          it("innermost", () => Expect.equals("firstinnerinnermost", text));
        });
        before(() => text += "inner");
      });
      it("first 3", () => Expect.equals("first", text));
    });

    describe("second", (){
      before(() => text = "");
      it("innermost", () => Expect.equals("", text));
    });
  }  
}

// NOTE - this spec depends on it()'s running in order.
//        if we implement random order running, we'll 
//        need to disable it for this spec.
class BeforeAndAfterSpec_WithAfters extends Spec {
  var inTheHat;

  spec() {
    describe("foo", (){
      after(() => inTheHat = "It's gone!");

      it("now it's here", (){
        Expect.isNull(inTheHat);
        inTheHat = "Bunny";
        Expect.equals("Bunny", inTheHat);
      });

      it("now it's gone!", (){
        Expect.equals("It's gone!", inTheHat);
      });
    });
  }
}

class BeforeAndAfterSpec extends SpecMap {
  spec() {

    var with1Before  = new BeforeAndAfterSpec_With1Before();
    var with2Befores = new BeforeAndAfterSpec_With2Befores();
    var withNested   = new BeforeAndAfterSpec_WithNestedDescribes();
    var withAfters   = new BeforeAndAfterSpec_WithAfters();

    describe("Before", {

      "can have 1 before hook": (){
        with1Before.run();

        // TODO this would be more ideal IMHO and it would get us stags 
        //      that we'll be able to use from formatters.
        // Expect.equals(2, with1Before.results.passedCount);

        Expect.equals(SpecExampleResult.passed, with1Before.describes[0].examples[0].result);
        Expect.equals(SpecExampleResult.passed, with1Before.describes[0].examples[1].result);
      },

      "can have many before hooks": (){
        with2Befores.run();

        Expect.equals(SpecExampleResult.passed, with1Before.describes[0].examples[1].result);
      },

      "can have many before hooks in nested describes": (){
        withNested.run();

        Expect.equals(SpecExampleResult.passed, withNested.describes[0].examples[0].result);
        Expect.equals(SpecExampleResult.passed, withNested.describes[0].examples[1].result);
        Expect.equals(SpecExampleResult.passed, withNested.describes[0].describes[0].examples[0].result);
        Expect.equals(SpecExampleResult.passed, withNested.describes[0].describes[0].describes[0].examples[0].result);
        Expect.equals(SpecExampleResult.passed, withNested.describes[1].examples[0].result);
      }

    });

    describe("After", {
      "can have 1 after hook": (){
        withAfters.run();

        Expect.equals(SpecExampleResult.passed, withAfters.describes[0].examples[0].result);
        Expect.equals(SpecExampleResult.passed, withAfters.describes[0].examples[1].result);
      }
    });
  }
}
