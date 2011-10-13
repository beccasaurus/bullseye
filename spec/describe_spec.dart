class DescribeSpec_NoExamples extends Spec {
  spec(){ describe("desc", (){}); }
}
class DescribeSpec_ManyExamples extends Spec {
  spec() {
    describe("desc", (){
      it("should do stuff");
      it("should do other stuff");
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
        var describe = new DescribeSpec_ManyExamples().describes[0];

        Expect.equals(2, describe.examples.length);
        Expect.equals("should do stuff", describe.examples[0].name);
        Expect.equals("should do other stuff", describe.examples[1].name);
      },

      "can have many sub-describes with no examples": null,

      "can have many sub-describes with examples": null

    });
  }
}
