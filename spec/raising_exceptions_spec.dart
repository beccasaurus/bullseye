class RaisingExceptionsSpec_Example extends Spec {
  spec() {
    describe("My specs", (){
      // NOTE: using fail() or even pending() will also throw exceptions
      // NOTE: assertion failures (eg. Expect.equals()) will also throw exceptions
      it("the Exception thrown here (even an ExpectException) will bubble up", (){
        throw new ExpectException("boom!");
      });
    });
  }
}

class RaisingExceptionsSpec extends SpecDartTest {
  spec() {
    describe("Configuring Raising Exceptions", {

      // TODO s/raise/throw/g -> throw is more conventional with Dart
      "Specs.raiseExceptions() will let any exceptions thrown by your tests bubble up (out of Specs.run())": (){
        Specs.raiseExceptions();

        Expect.throws(() => Specs.run([new RaisingExceptionsSpec_Example()]),
          check: (exception) => exception is ExpectException && exception.toString() == "boom!");

        Specs.dontRaiseExceptions(); // Set it back to the default
      },

      "Specs.dontRaiseExceptions() won't let any exceptions thrown by your tests bubble up (default)": (){
        Specs.dontRaiseExceptions();
        Specs.run([new RaisingExceptionsSpec_Example()]); // No exceptions thrown
      }

    });
  }
}
