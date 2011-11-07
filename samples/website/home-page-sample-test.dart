#import("dog.dart");
#import("../../src/bullseye.dart");

main() => Bullseye.run([new DogTest()]);

class DogTest extends BullseyeTestCase {
  Dog dog;

  testCase() {

    setUp(() => dog = new Dog(name: "Rover"));

    test("has a name", (){
      Expect.equals("Rover", dog.name);
    });

    test("can bark", (){
      ()=> Expect.equals("Woof!  My name is Rover", dog.bark());
    });

  }
}
