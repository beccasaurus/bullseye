class ExampleSpec_Example extends Spec {
  spec() {
    describe("something", (){
      it("should pass", (){
        Expect.equals(1, 1);
      });
      it("should fail", (){
        Expect.equals(1, "Not Equal!");
      });
      it("should have an error", (){
        "".stringsDontHaveThisMethod__OhNoes();
      });
      it("should be pending");
    });
  }
}

class ExampleSpec extends SpecDartTest {
  spec() {

    var spec = new ExampleSpec_Example();

    describe("Example", {
      "has reference to SpecDescribe": (){
        var describe = spec.describes[0];
        var example  = describe.examples[0];

        Expect.identical(describe, example.describe);
      }
    });

    describe("Running Examples", {

      "passed": (){
        var example = spec.describes[0].examples[0];
        Expect.equals("should pass", example.name);
        Expect.isNull(example.result);

        example.run();

        Expect.equals(SpecExampleResult.passed, example.result);
      },

      "failed": (){
        var example = spec.describes[0].examples[1];
        Expect.equals("should fail", example.name);
        Expect.isNull(example.result);
        Expect.isNull(example.exception);

        example.run();

        Expect.equals(SpecExampleResult.failed, example.result);

        var exception = example.exception;
        Expect.isNotNull(exception);
        Expect.isTrue(exception is ExpectException);
        Expect.equals("Expect.equals(expected: <1>, actual: <Not Equal!>) fails.", exception.message);
      },

      "error": (){
        var example = spec.describes[0].examples[2];
        Expect.equals("should have an error", example.name);
        Expect.isNull(example.result);
        Expect.isNull(example.exception);

        example.run();

        Expect.equals(SpecExampleResult.error, example.result);

        var exception = example.exception;
        Expect.isNotNull(exception);
        Expect.isTrue(exception is NoSuchMethodException);
        Expect.equals("NoSuchMethodException - receiver: '' function name: 'stringsDontHaveThisMethod__OhNoes' arguments: []]", exception.toString());
      },

      "pending": (){
        var example = spec.describes[0].examples[3];
        Expect.equals("should be pending", example.name);
        Expect.isNull(example.result);

        example.run();

        Expect.equals(SpecExampleResult.pending, example.result);
      }

    });
  }
}
