#import("../../src/bullseye.dart"); // assumes you have bullseye.dart in the current directory
#import("dog.dart");      // assumes this is your library that contains the Dog class

// When this script runs, Bullseye will run all of the spec instances you give it
main() => Bullseye.run([new DogSpec()]);

// We extend the BullseyeSpec class which lets us use the BDD DSL to define our tests
class DogSpec extends BullseyeSpec {
  Dog dog;

  // Define your spec inside the spec() method
  spec() {

    before(() => dog = new Dog(name: "Rover"));

    it("has a name", () => Expect.equals("Rover", dog.name));

    it("can bark its name", (){ 
      Expect.equals("Woof!  My name is Rover", dog.bark());
      dog.name = "Spot";
      Expect.equals("Woof!  My name is Spot", dog.bark());
    }); 
  }   
}
