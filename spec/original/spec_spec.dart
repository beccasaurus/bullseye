class OriginalSpecSpec extends SpecMap_Bullseye {
  spec() {

    var noDescribes          = new SpecSpec_NoDescribesSpec();
    var manyDescribes        = new SpecSpec_ManyDescribesSpec();
    var testsAndDescribes = new SpecSpec_TestsAndDescribesSpec();

    describe("Spec", {

      "can have no testFixtures": (){
        Expect.equals(0, noDescribes.testFixtures.length);
      },

      "can have many testFixtures": (){
        Expect.equals(2, manyDescribes.testFixtures.length);
        Expect.equals("Foo", manyDescribes.testFixtures[0].description);
        Expect.equals("Bar", manyDescribes.testFixtures[1].description);
      },

      "can have many tests": (){
        Expect.equals(1, testsAndDescribes.tests.length);
        Expect.equals(1, testsAndDescribes.testFixtures.length);
        Expect.equals(1, testsAndDescribes.testFixtures[0].tests.length);

        Expect.equals("SpecSpec_TestsAndDescribes", testsAndDescribes.description);
        Expect.equals("foo", testsAndDescribes.tests[0].description);

        Expect.equals("stuff", testsAndDescribes.testFixtures[0].description);
        Expect.equals("bar", testsAndDescribes.testFixtures[0].tests[0].description);
      }

    });
  }
}

class SpecSpec_NoDescribesSpec extends BullseyeSpec {}
class SpecSpec_ManyDescribesSpec extends BullseyeSpec {
  spec() {
    describe("Foo");
    describe("Bar");
  }
}
class SpecSpec_TestsAndDescribesSpec extends BullseyeSpec {
  spec() {
    it("foo");
    describe("stuff", (){
      it("bar");
    });
  }
}
