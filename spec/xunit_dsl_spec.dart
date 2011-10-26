class xUnitDSLSpec extends SpecDartTest {
  spec() {
    describe("xUnit DSL", {

      "can run sample": (){
        var testCase  = new xUnitDSLSpec_Example();
        var testFixture1 = testCase.testFixtures[0];
        var testFixture2 = testCase.testFixtures[1];
        testFixture1.examples.forEach((ex) => Expect.isNull(ex.result));
        testFixture2.examples.forEach((ex) => Expect.isNull(ex.result));

        testCase.run(); // TODO should return a result

        // foo
        Expect.equals(SpecExampleResult.passed,  testFixture1.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  testFixture1.examples[1].result);
        Expect.equals(SpecExampleResult.error,   testFixture1.examples[2].result);
        Expect.equals(SpecExampleResult.pending, testFixture1.examples[3].result);

        // bar
        Expect.equals(SpecExampleResult.pending, testFixture2.examples[0].result);
        Expect.equals(SpecExampleResult.failed,  testFixture2.testFixtures[0].testFixtures[0].examples[0].result);
        Expect.equals(SpecExampleResult.passed,  testFixture2.examples[1].result);

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
