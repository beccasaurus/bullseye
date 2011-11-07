#import("dog.dart");
#import("../../src/bullseye.dart");

class DogSpec extends Spec {

  // DogSpec is a regular class so you can add fields that your tests can access.
  // Be sure to reset your fields in a before block so they're the same for each test.
  Dog dog;

  // You must override spec() in your BullseyeSpec.
  // We will call it on your instance, allowing you to define your tests.
  spec() {

    // Methods available from within spec():
    //
    // before:   accepts a function that will be run before each test in this context
    // after:    accepts a function that will be run after each test in this context
    // it:       accepts a description & function, representing your actual test code
    // describe: accepts a description & function you can define nested tests/etc in

    before(() => dog = new Dog(name: "Rover"));

    it("has name", () => Expect.equals("Rover", dog.name));

    it("can bark", (){
      Expect.equals("Woof!  My name is Rover", dog.bark());
    });

    // Let's say that Golden Retrievers bark differently.
    // We can define a nested context to add some Golden Retriever-specific tests.
    describe("Golden Retriever", (){

      before(() => dog.breed = "Golden Retriever");

      // Before this test runs, the outer before (which creates a new Dog) will run, 
      // then this nested context's before (which changes the dog's breed) will rull.
      it("barks really happily", (){
        Expect.equals("Woof!  I'm a happy dog!", dog.bark());
      });

      // Nested contexts can have nested contexts, etc etc
      describe("whole name is Bob", (){
        before(() => dog.name = "Bob");

        // Note: this test has no function defined.
        // This test will show up as "pending" when run, giving you a way to 
        // document upcoming behaviors that you're not ready to write tests for.
        it("does something different");
      });
    });
  }
}

// Let's make another test
class BreedSpec extends Spec {

  // Any tests defined directly inside of defineTests() are put into this 
  // test case's "default" context.  By default, we try to get the name of 
  // your class and we use that for this context's description, eg. "BreedTest".
  // If you want to overide this, you can create a description getter.
  get description() => "Dog Breed";

  // Let's just define 1 pending test for now
  spec() {
    it("has a name");
  }
}

// Bullseye.run accepts an Iterable<TestCase>, so all you need to do 
// is pass it a list of instances of each of your BullseyeTestCase classes.
main() => Bullseye.run([
  new DogSpec(), new BreedSpec()
]);
