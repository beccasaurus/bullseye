class SpecSpec extends SpecDartTest {
  spec() {

    var noDescribes          = new SpecSpec_NoDescribesSpec();
    var manyDescribes        = new SpecSpec_ManyDescribesSpec();
    var examplesAndDescribes = new SpecSpec_ExamplesAndDescribesSpec();

    describe("Spec", {

      "can have no testFixtures": (){
        Expect.equals(0, noDescribes.testFixtures.length);
      },

      "can have many testFixtures": (){
        Expect.equals(2, manyDescribes.testFixtures.length);
        Expect.equals("Foo", manyDescribes.testFixtures[0].subject);
        Expect.equals("Bar", manyDescribes.testFixtures[1].subject);
      },

      "can have many examples": (){
        Expect.equals(1, examplesAndDescribes.examples.length);
        Expect.equals(1, examplesAndDescribes.testFixtures.length);
        Expect.equals(1, examplesAndDescribes.testFixtures[0].examples.length);

        Expect.equals("SpecSpec_ExamplesAndDescribes", examplesAndDescribes.subject);
        Expect.equals("foo", examplesAndDescribes.examples[0].name);

        Expect.equals("stuff", examplesAndDescribes.testFixtures[0].subject);
        Expect.equals("bar", examplesAndDescribes.testFixtures[0].examples[0].name);
      }

    });
  }
}

class SpecSpec_NoDescribesSpec extends Spec {}
class SpecSpec_ManyDescribesSpec extends Spec {
  spec() {
    describe("Foo");
    describe("Bar");
  }
}
class SpecSpec_ExamplesAndDescribesSpec extends Spec {
  spec() {
    it("foo");
    describe("stuff", (){
      it("bar");
    });
  }
}
