class SpecDocFormatter extends SpecFormatter {
  header() {
    write("~ Spec.dart ${Spec.VERSION} ~");
  }

  beforeExample(example) {
    write(example.name);
  }
}
