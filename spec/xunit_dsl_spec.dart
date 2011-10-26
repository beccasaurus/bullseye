class xUnitDSLSpec extends SpecMap_Bullseye {
  spec() {
    describe("xUnit DSL", {

      "can run sample": (){
        var testCase  = new xUnitDSLSpec_Test();
        var testFixture1 = testCase.testFixtures[0];
        var testFixture2 = testCase.testFixtures[1];
        testFixture1.tests.forEach((ex) => Expect.isNull(ex.result));
        testFixture2.tests.forEach((ex) => Expect.isNull(ex.result));

        testCase.run(); // TODO should return a result

        // foo
        Expect.equals(BullseyeTestResult.passed,  testFixture1.tests[0].result);
        Expect.equals(BullseyeTestResult.failed,  testFixture1.tests[1].result);
        Expect.equals(BullseyeTestResult.error,   testFixture1.tests[2].result);
        Expect.equals(BullseyeTestResult.pending, testFixture1.tests[3].result);

        // bar
        Expect.equals(BullseyeTestResult.pending, testFixture2.tests[0].result);
        Expect.equals(BullseyeTestResult.failed,  testFixture2.testFixtures[0].testFixtures[0].tests[0].result);
        Expect.equals(BullseyeTestResult.passed,  testFixture2.tests[1].result);

        // Check that setUp and tearDown run as expected
        Expect.equals("ududududUDUDUXYD", testCase.text);
      }

    });
  }
}

class xUnitDSLSpec_Test extends TestCase {
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
