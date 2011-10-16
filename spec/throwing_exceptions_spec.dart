class ThrowingExceptionsSpec_Example extends Spec {
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

class ThrowingExceptionsSpec extends SpecDartTest {
  spec() {
    describe("Configuring Throwing Exceptions", {

      "Specs.throwExceptions() will let any exceptions thrown by your tests bubble up (out of Specs.run())": (){
        Specs.throwExceptions();

        Expect.throws(() => Specs.run([new ThrowingExceptionsSpec_Example()]),
          check: (exception) => exception is ExpectException && exception.toString() == "boom!");

        Specs.dontThrowExceptions(); // Set it back to the default
      },

      "Specs.dontThrowExceptions() won't let any exceptions thrown by your tests bubble up (default)": (){
        Specs.dontThrowExceptions();
        Specs.run([new ThrowingExceptionsSpec_Example()]); // No exceptions thrown
      }

    });
  }
}
