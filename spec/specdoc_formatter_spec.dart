class SpecDocFormatterSpec extends SpecMap_Bullseye {
  spec() {

    var buffer    = new StringBuffer();
    var formatter = new SpecDocFormatter();
    formatter.colorize      = false;
    formatter.printToStdout = false;
    formatter.logger((text) => buffer.add(text));

    Bullseye.formatter = formatter;
    Bullseye.run([new SpecDocFormatterSpec_Test()]);

    var output = buffer.toString();

    describe("SpecDocFormatter", {

      "prints Spec.dart header": () => Expect.isTrue(output.contains("~ Spec.dart ${BullseyeTestFixtureDefinition.VERSION} ~\n\n", 0)),

      "prints testFixtures": (){
        Expect.isTrue(output.contains("\nSpecDocFormatterSpec_Test", 0));
        Expect.isTrue(output.contains("\n  foo", 0));
        Expect.isTrue(output.contains("\n  bar", 0));
      },

      "prints tests (indented under descibes)": (){
        Expect.isTrue(output.contains("\n  foo\n    foo-1\n    foo-2\n", 0));
        Expect.isTrue(output.contains("\n  bar\n    bar-1\n    [PENDING] bar-2\n", 0));
      },

      "prints summary": (){
        Expect.isTrue(output.contains("6 Tests, 1 Failures, 1 Errors, 3 Pending", 0));
      },

      "prints out the details of any failed tests": (){
        Expect.isTrue(output.contains("\nFailures:\n\n  bar bar-1\n    Exception: Expect.isTrue(false) fails.", 0));
      },

      "prints out the details of any tests that raised Exceptions": (){
        Expect.isTrue(output.contains("\nFailures:\n\n  bar bar-1\n    Exception: Expect.isTrue(false) fails.", 0));
      },

      "prints out the details of any pending tests": (){
        Expect.isTrue(output.contains("\nPending:\n\n  bar bar-2", 0));
      },

      "indents nested testFixtures/it's": (){
        Expect.isTrue(output.contains("bar\n    bar-1\n    [PENDING] bar-2\n    inner\n      [custom pending message] is indented more\n      one\n        [PENDING] more", 0));
      },

      "prints out custom pending messages": (){
        Expect.isTrue(output.contains("[custom pending message] is indented more", 0));
      },

      "prints out custom pending messages in pending summary": (){
        Expect.isTrue(output.contains("inner is indented more [custom pending message]", 0));
      }
    });

    buffer = new StringBuffer();
    Bullseye.formatter.colorize = true;
    Bullseye.run([new SpecDocFormatterSpec_Test()]);
    var colored = buffer.toString();

    describe("SpecDocFormatter with colored output", {

      "passing tests should be printed in green": (){
        Expect.isTrue(colored.contains("foo\n\x1b\x5b;0;32m    foo-1", 0));
      },

      "failed tests should be printed in red": (){
        Expect.isTrue(colored.contains("bar\n\x1b\x5b;0;31m    bar-1", 0));
      },

      "error tests should be printed in red": (){
        Expect.isTrue(colored.contains("\n\x1b\x5b;0;31m    foo-2", 0));
      },

      "pending tests should be printed in yellow": (){
        Expect.isTrue(colored.contains("\n\x1b\x5b;0;33m      [custom pending message] is indented more", 0));
      },

      "the summary line should be red because atleast 1 test failed": (){
        Expect.isTrue(colored.contains("\x1b\x5b;0;31m\n12 Tests, 2 Failures, 2 Errors, 6 Pending", 0));
      }
    });
  }
}

class SpecDocFormatterSpec_Test extends Spec {
  spec() {
    describe("foo", (){
      it("foo-1", () => Expect.isTrue(true));
      it("foo-2", () { throw new Exception("My Exception"); });
    });
    describe("bar", (){
      it("bar-1", () => Expect.isTrue(false));
      it("bar-2");

      describe("inner", (){
        it("is indented more", (){
          pending("custom pending message");
        });
        describe("one", (){
          it("more");
        });
      });
    });
  }
}
