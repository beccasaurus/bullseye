class BeforeAndAfterSpec extends SpecMap_Bullseye {
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

        Expect.equals(BullseyeTestResult.passed, with1Before.testFixtures[0].tests[0].result);
        Expect.equals(BullseyeTestResult.passed, with1Before.testFixtures[0].tests[1].result);
      },

      "can have many before hooks": (){
        with2Befores.run();

        Expect.equals(BullseyeTestResult.passed, with1Before.testFixtures[0].tests[1].result);
      },

      "can have many before hooks in nested testFixtures": (){
        withNested.run();

        // Check that all of the specs passed
        withNested.testFixtures.forEach((testFixture) {
          testFixture.tests.forEach((test) {
            Expect.equals(BullseyeTestResult.passed, test.result);
          });
        });

        // Check that the 'output' var has the text we would expect.
        // You need to go read the spec carefully above to see how it 
        // runs the 'F'irst before block for each it and then the 
        // 'I'nner before block for each it in the Inner testFixture, etc.
        Expect.stringEquals("FFFFIFIitFIFI", withNested.output);
      }

    });

    describe("After", {
      "can have 1 after hook": (){
        withAfters.run();

        Expect.equals(BullseyeTestResult.passed, withAfters.testFixtures[0].tests[0].result);
        Expect.equals(BullseyeTestResult.passed, withAfters.testFixtures[0].tests[1].result);
      }
    });
  }
}

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

// This is a bit of a monster ... sorry  :/
// I'll find a btter pattern for testing these types of scenarios.
class BeforeAndAfterSpec_WithNestedDescribes extends Spec {
  // Using fields is problematic because you must 
  // explicitly set their defaults in a before() 
  // in every describe in your spec.
  //
  // See setup() for defining an instance method 
  // that is run before every test in a spec.
  var text = "";
  var output = "";

  spec() {
    describe("first", (){
      before(() => output += "F");
      before(() => text = "");
      it("first 1", () => Expect.equals("first", text));
      before(() => text += "first");
      it("first 2", () => Expect.equals("first", text));
      describe("inner", (){
        before(() => output += "I");
        it("inner", () => Expect.equals("firstinner", text));
        it("add to output", () => output += "it");
        describe("innermost", (){
          before(() => text += "innermost");
          it("innermost", () => Expect.equals("firstinnerinnermost", text));
          describe("innermostest", (){
            before(() => text += "even more!");
            it("innermostest", (){
              Expect.equals("firstinnerinnermost even more!", text);
            });
          });
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
