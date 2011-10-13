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
      // it("outer bottom it"); // enable this AFTER green, cause it'll require a bit of refactoring
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

class DescribeSpec extends SpecMap {
  spec() {

    var noExamples   = new DescribeSpec_NoExamples();
    var manyExamples = new DescribeSpec_ManyExamples();

    describe("Describe", {

      "can have no examples": (){
        var describe = new DescribeSpec_NoExamples().describes[0];

        Expect.equals(0, describe.examples.length);
      },

      "can have many examples": (){
        var spec      = new DescribeSpec_ManyExamples();
        var describe1 = spec.describes[0];
        var describe2 = spec.describes[1];

        Expect.equals(2, describe1.examples.length);
        Expect.equals("should do stuff", describe1.examples[0].name);
        Expect.equals("should do other stuff", describe1.examples[1].name);

        Expect.equals(1, describe2.examples.length);
        Expect.equals("should do more stuff", describe2.examples[0].name);
      },

      "can have many sub-describes": (){
        var spec = new DescribeSpec_SubDescribes();

        // the spec only has it's 2 describes, the other describes 
        // are stored inside each of these describes.
        Expect.equals(2, spec.describes.length);

        Expect.equals("outer top it", spec.describes[0].examples[0].name);
        Expect.equals("inner first", spec.describes[0].describes[0].subject);
        Expect.equals("inner first it", spec.describes[0].describes[0].examples[0].name);

        Expect.equals("inner second", spec.describes[1].describes[0].subject);
        Expect.equals("inner inner second", spec.describes[1].describes[0].describes[0].subject);
        Expect.equals("inner inner second it", spec.describes[1].describes[0].describes[0].examples[0].name);
      }

    });
  }
}
