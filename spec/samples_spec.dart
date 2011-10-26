// Some sanity check style specs to make sure that all 
// of the samples in our samples/ directory are working 
// with the latest version of Spec.dart.
class SamplesSpec extends SpecDartTest {

  // Given a spec, this runs the spec thru 
  // Specs.run using the SpecDocFormatter and 
  // returns a String of the resulting output.
  String getSpecOutput(BullseyeTestFixture testFixture) {
    var buffer    = new StringBuffer();
    var formatter = new SpecDocFormatter();
    formatter.colorize      = false;
    formatter.printToStdout = false;
    formatter.logger((text) => buffer.add(text));
    Specs.formatter = formatter;
    Specs.run([testFixture]);
    return buffer.toString();
  }

  String removeIndent(String indented) {
    var spaces        = 26;
    var withoutIndent = "";
    indented.split("\n").forEach((line) {
      if (line.length > spaces)
        withoutIndent += line.substring(spaces) + "\n";
      else
        withoutIndent += line + "\n";
    });
    return withoutIndent;
  }

  printString(var str) {
    var lines = str.split("\n");
    for (var i = 0; i < lines.length; i++)
      print("$i [${lines[i]}]");
  }

  spec() {
    describe("BowlingSpec", {
      "OK": (){
        var expected = """~ Spec.dart 0.1.0 ~

                          Bowling
                            #score returns 0 for all gutter game

                          1 Examples, 0 Failures""";

        Expect.stringEquals(removeIndent(expected), getSpecOutput(new BowlingSpec()));
      }
    });
  }
}
