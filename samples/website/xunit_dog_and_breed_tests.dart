#import("../../src/bullseye.dart");
#import("dog.dart");

class DogTest extends BullseyeTestCase {

  // DogTest is a regular class so you can add fields that your tests can access.
  // Be sure to reset your fields in a setUp block so they're the same for each test.
  Dog dog;

  // You must override defineTests() in your BullseyeTestCase.
  // We will call it on your instance, allowing you to define your tests.
  defineTests() {

    // Methods available from within defineTests():
    //
    // setUp:    accepts a function that will be run before each test in this context
    // tearDown: accepts a function that will be run after each test in this context
    // test:     accepts a description & function, representing your actual test code
    // context:  accepts a description & function, in which you can define nested tests/etc

    setUp(() => dog = new Dog(name: "Rover"));

    test("has name", () => Expect.equals("Rover", dog.name));

    test("can bark", (){
      Expect.equals("Woof!  My name is Rover", dog.bark());
    });

    // Let's say that Golden Retrievers bark differently.
    // We can define a nested context to add some Golden Retriever-specific tests.
    context("Golden Retriever", (){

      setUp(() => dog.breed = "Golden Retriever");

      // Before this test runs, the outer setUp (which instantiates a new Dog) will run, 
      // and then this nested context's setUp (which changes the dog's breed) will rull.
      test("barks really happily", (){
        Expect.equals("Woof!  I'm a happy dog!", dog.bark());
      });

      // Nested contexts can have nested contexts, etc etc
      context("whole name is Bob", (){
        setUp(() => dog.name = "Bob");

        // Note: this test has no function defined.
        // This test will show up as "pending" when run, giving you a way to 
        // document upcoming behaviors that you're not ready to write tests for.
        test("does something different");
      });
    });
  }
}

class BreedTest extends BullseyeTestCase {
  get description() => "Dog Breed";

  defineTests() {
    test("has a name");
  }
}

// Bullseye.run accepts an Iterable<TestCase>, so all you need to do 
// is pass it a list of instances of each of your BullseyeTestCase classes.
main() => Bullseye.run([
  new DogTest(), new BreedTest()
]);
