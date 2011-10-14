class SpecDocFormatterSpec_Example extends Spec {
  spec() {
    describe("foo", (){
    });
    describe("bar", (){
    });
  }
}

class SpecDocFormatterSpec extends SpecDartTest {
  spec() {

    var buffer    = new StringBuffer();
    var formatter = new SpecDocFormatter();
    formatter.printToStdout = false;
    formatter.logger((text) => buffer.add(text));

    Specs.formatter = formatter;
    Specs.run(new SpecDocFormatterSpec_Example());

    var output = buffer.toString();
    print("OUTPUT:\n$output");

    describe("SpecDocFormatter", {

      "prints Spec.dart header": () => Expect.isTrue(output.indexOf("~ Spec.dart ${Spec.VERSION} ~", 0) > -1),

      "prints describes": null,

      "prints examples (indented under descibes)": null

    });
  }
}
