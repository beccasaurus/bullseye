class DescribeSpec_NoExamples extends Spec {}
class DescribeSpec_ManyExamples extends Spec {}
class DescribeSpec_ManyDescribesNoExamples extends Spec {}
class DescribeSpec_ManyDescribesManyExamples extends Spec {}

class DescribeSpec extends SpecMap {
  spec() {

    var noExamples                = new DescribeSpec_NoExamples();
    var manyExamples              = new DescribeSpec_ManyExamples();
    var manyDescribesNoExamples   = new DescribeSpec_ManyDescribesNoExamples();
    var manyDescribesManyExamples = new DescribeSpec_ManyDescribesManyExamples();

    describe("Describe", {

      "can have no examples": null,

      "can have many examples": null,

      "can have many sub-describes with no examples": null,

      "can have many sub-describes with examples": null

    });
  }
}
