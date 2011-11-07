// Some sanity check style specs to make sure that all 
// of the samples in our samples/ directory are working 
// with the latest version of Bullseye.
class OriginalSamplesSpec extends SpecMap_Bullseye {

  // Given a spec, this runs the spec thru 
  // Bullseye.run using the SpecDocFormatter and 
  // returns a String of the statusing output.
  String getSpecOutput(BullseyeTestFixture testFixture) {
    var buffer    = new StringBuffer();
    var formatter = new SpecDocFormatter();
    formatter.colorize      = false;
    formatter.printToStdout = false;
    formatter.logger((text) => buffer.add(text));
    Bullseye.formatter = formatter;
    Bullseye.run([testFixture]);
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
        var expected = """~ Bullseye 0.1.0 ~

                          Bowling
                            #score returns 0 for all gutter game

                          1 Tests, 0 Failures""";

        Expect.stringEquals(removeIndent(expected), getSpecOutput(new BowlingSpec()));
      }
    });
  }
}
