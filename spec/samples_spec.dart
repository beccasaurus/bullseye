// Some sanity check style specs to make sure that all 
// of the samples in our samples/ directory are working 
// with the latest version of Spec.dart.
class SamplesSpec extends SpecDartTest {

  // Given a spec, this runs the spec thru 
  // Specs.run using the SpecDocFormatter and 
  // returns a String of the resulting output.
  String getSpecOutput(Spec spec) {
    var buffer    = new StringBuffer();
    var formatter = new SpecDocFormatter();
    formatter.printToStdout = false;
    formatter.logger((text) => buffer.add(text));
    Specs.formatter = formatter;
    Specs.run([spec]);
    return buffer.toString();
  }

  spec() {
    describe("BowlingSpec", {
      "OK": (){
        var expected = """~ Spec.dart 0.1.0 ~

Bowling #score
  returns 0 for all gutter game

1 Examples, 0 Failures
""";

        Expect.equals(expected, getSpecOutput(new BowlingSpec()));
      }
    });
  }
}
