class OriginalxUnitDSLSpec extends SpecMap_Bullseye {
  spec() {
    describe("xUnit DSL", {

      "can run sample": (){
        var testCase  = new xUnitDSLSpec_Test();
        var testFixture1 = testCase.testFixtures[0];
        var testFixture2 = testCase.testFixtures[1];
        testFixture1.tests.forEach((ex) => Expect.isNull(ex.status));
        testFixture2.tests.forEach((ex) => Expect.isNull(ex.status));

        testCase.run(); // TODO should return a status

        // foo
        Expect.equals(BullseyeTestStatus.passed,  testFixture1.tests[0].status);
        Expect.equals(BullseyeTestStatus.failed,  testFixture1.tests[1].status);
        Expect.equals(BullseyeTestStatus.error,   testFixture1.tests[2].status);
        Expect.equals(BullseyeTestStatus.pending, testFixture1.tests[3].status);

        // bar
        Expect.equals(BullseyeTestStatus.pending, testFixture2.tests[0].status);
        Expect.equals(BullseyeTestStatus.failed,  testFixture2.testFixtures[0].testFixtures[0].tests[0].status);
        Expect.equals(BullseyeTestStatus.passed,  testFixture2.tests[1].status);

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
