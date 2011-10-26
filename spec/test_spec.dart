class TestSpec extends SpecMap_Bullseye {
  spec() {

    var spec = new TestSpec_Test();

    // TODO expand on this!  When we bring over meta/tags/etc?
    describe("Test", {
      "has reference to BullseyeTestFixture": (){
        var testFixture = spec.testFixtures[0];
        var test  = testFixture.tests[0];

        Expect.identical(testFixture, test.testFixture);
      }
    });

    describe("Running Tests", {

      "passed": (){
        var test = spec.testFixtures[0].tests[0];
        Expect.equals("should pass", test.name);
        Expect.isNull(test.result);

        test.run();

        Expect.equals(BullseyeTestResult.passed, test.result);
      },

      "failed": (){
        var test = spec.testFixtures[0].tests[1];
        Expect.equals("should fail", test.name);
        Expect.isNull(test.result);
        Expect.isNull(test.exception);

        test.run();

        Expect.equals(BullseyeTestResult.failed, test.result);

        var exception = test.exception;
        Expect.isNotNull(exception);
        Expect.isTrue(exception is ExpectException);
        Expect.equals("Expect.equals(expected: <1>, actual: <Not Equal!>) fails.", exception.message);
      },

      "error": (){
        var test = spec.testFixtures[0].tests[2];
        Expect.equals("should have an error", test.name);
        Expect.isNull(test.result);
        Expect.isNull(test.exception);

        test.run();

        Expect.equals(BullseyeTestResult.error, test.result);

        var exception = test.exception;
        Expect.isNotNull(exception);
        Expect.isTrue(exception is NoSuchMethodException);
        Expect.equals("NoSuchMethodException - receiver: '' function name: 'stringsDontHaveThisMethod__OhNoes' arguments: []]", exception.toString());
      },

      "pending": (){
        var test = spec.testFixtures[0].tests[3];
        Expect.equals("should be pending", test.name);
        Expect.isNull(test.result);

        test.run();

        Expect.equals(BullseyeTestResult.pending, test.result);
      }

    });
  }
}

class TestSpec_Test extends Spec {
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
