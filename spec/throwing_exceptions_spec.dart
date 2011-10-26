class ThrowingExceptionsSpec extends SpecMap_Bullseye {
  spec() {
    describe("Configuring Throwing Exceptions", {

      "Bullseye.throwExceptions() will let any exceptions thrown by your tests bubble up (out of Bullseye.run())": (){
        Bullseye.throwExceptions();

        Expect.throws(() => Bullseye.run([new ThrowingExceptionsSpec_Example()]),
          check: (exception) => exception is ExpectException && exception.toString() == "boom!");

        Bullseye.dontThrowExceptions(); // Set it back to the default
      },

      "Bullseye.dontThrowExceptions() won't let any exceptions thrown by your tests bubble up (default)": (){
        Bullseye.dontThrowExceptions();
        Bullseye.run([new ThrowingExceptionsSpec_Example()]); // No exceptions thrown
      }

    });
  }
}

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
