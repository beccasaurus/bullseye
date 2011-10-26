class xUnitDSLSpec extends SpecDartTest {
  spec() {
    describe("xUnit DSL", {

      "can run sample": (){
        var testCase  = new xUnitDSLSpec_Example();
        var describe1 = testCase.describes[0];
        var describe2 = testCase.describes[1];
        describe1.examples.forEach((ex) => Expect.isNull(ex.result));
        describe2.examples.forEach((ex) => Expect.isNull(ex.result));

        testCase.run(); // TODO should return a result

        // foo
        Expect.equals(SpecExampleResult.passed,  describe1.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  describe1.examples[1].result);
        Expect.equals(SpecExampleResult.error,   describe1.examples[2].result);
        Expect.equals(SpecExampleResult.pending, describe1.examples[3].result);

        // bar
        Expect.equals(SpecExampleResult.pending, describe2.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  describe2.describes[0].describes[0].examples[0].result);
        Expect.equals(SpecExampleResult.passed,  describe2.examples[1].result);

        // Check that setUp and tearDown run as expected
        Expect.equals("ududududUDUDUXYD", testCase.text);
      }

    });
  }
}

class xUnitDSLSpec_Example extends TestCase {
  var text = "";

  defineTests() {

    context("foo", (){
      setUp(() => text += "u");
      tearDown(() => text += "d");

      test("passes", (){});
      test("fails", (){ Expect.isTrue(false); });
      test("blows up", (){ "".noMethodSoThisGoBoom(); });
      test("pending");
    });

    context("bar", (){
      setUp(() => text += "U");
      tearDown(() => text += "D");
      test("pending");
      context("inner", (){
        context("inner-inner", (){
          setUp(() => text += "X");
          tearDown(() => text += "Y");
          test("fails", (){ Expect.isTrue(false); });
        });
      });
      test("passed", (){});
    });

  }
}
