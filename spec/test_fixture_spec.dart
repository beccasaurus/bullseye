class TestFixtureSpec extends SpecDartTest {
  spec() {

    var noExamples   = new DescribeSpec_NoExamples();
    var manyExamples = new DescribeSpec_ManyExamples();

    describe("TestFixture", {

      "can have no examples": (){
        var testFixture = new DescribeSpec_NoExamples().testFixtures[0];

        Expect.equals(0, testFixture.examples.length);
      },

      "can have many examples": (){
        var spec      = new DescribeSpec_ManyExamples();
        var testFixture1 = spec.testFixtures[0];
        var testFixture2 = spec.testFixtures[1];

        Expect.equals(2, testFixture1.examples.length);
        Expect.equals("should do stuff", testFixture1.examples[0].name);
        Expect.equals("should do other stuff", testFixture1.examples[1].name);

        Expect.equals(1, testFixture2.examples.length);
        Expect.equals("should do more stuff", testFixture2.examples[0].name);
      },

      "can have many sub-testFixtures": (){
        var spec = new DescribeSpec_SubDescribes();

        // the spec only has it's 2 testFixtures, the other testFixtures 
        // are stored inside each of these testFixtures.
        Expect.equals(2, spec.testFixtures.length);

        Expect.equals("outer top it", spec.testFixtures[0].examples[0].name);
        Expect.equals("inner first", spec.testFixtures[0].testFixtures[0].subject);
        Expect.equals("inner first it", spec.testFixtures[0].testFixtures[0].examples[0].name);
        Expect.equals("outer bottom it", spec.testFixtures[0].examples[1].name);

        Expect.equals("inner second", spec.testFixtures[1].testFixtures[0].subject);
        Expect.equals("inner inner second", spec.testFixtures[1].testFixtures[0].testFixtures[0].subject);
        Expect.equals("inner inner second it", spec.testFixtures[1].testFixtures[0].testFixtures[0].examples[0].name);
      }

    });
  }
}

class DescribeSpec_NoExamples extends Spec {
  spec(){ describe("desc", (){}); }
}
class DescribeSpec_ManyExamples extends Spec {
  spec() {
    describe("desc", (){
      it("should do stuff");
      it("should do other stuff");
    });
    describe("more", (){
      it("should do more stuff");
    });
  }
}
class DescribeSpec_SubDescribes extends Spec {
  spec() {
    describe("outer first", (){
      it("outer top it");
      describe("inner first", (){
        it("inner first it");
      }); 
      it("outer bottom it");
    });
    describe("outer second", (){
      describe("inner second", (){
        describe("inner inner second", (){
          it("inner inner second it");
        });
      });
    });
  }
}
