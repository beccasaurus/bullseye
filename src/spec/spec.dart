// Represents a single Spec
class Spec {

  // All of the SpecDescribe defined in this Spec
  List<SpecDescribe> describes;

  Spec() {
    describes = new List<SpecDescribe>();
    spec();
  }

  // You must override spec() in your Spec class 
  // and use it to define your spec.
  void spec() {}

  SpecDescribe describe([String subject = null, var fn = null]) {
    SpecDescribe describe = new SpecDescribe(subject: subject, fn: fn);
    describes.add(describe);
    describe.evaluate();
    return describe;
  }

  SpecExample it(String exampleName) {
    SpecDescribe currentDescribe = (describes.length == 0) ? null : describes.last();
    if (currentDescribe != null) {
      SpecExample example = new SpecExample(exampleName);
      currentDescribe.examples.add(example);
      return example;
    } else {
      throw new UnsupportedOperationException("it() cannot be used before calling describe()");
    }
  }

}
