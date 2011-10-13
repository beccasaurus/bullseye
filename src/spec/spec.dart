// Represents a single Spec
class Spec {

  // All of the SpecDescribe defined in this Spec
  List<SpecDescribe> describes;

  List<SpecDescribe> _currentDescribes;

  Spec() {
    describes         = new List<SpecDescribe>();
    _currentDescribes = new List<SpecDescribe>();
    spec();
  }

  // You must override spec() in your Spec class 
  // and use it to define your spec.
  void spec() {}

  SpecDescribe describe([String subject = null, var fn = null]) {
    SpecDescribe describe = new SpecDescribe(subject: subject, fn: fn);

    if (_currentDescribes.length == 0)
      describes.add(describe);
    else
      _currentDescribes.last().describes.add(describe);

    _currentDescribes.addLast(describe);
    describe.evaluate();
    _currentDescribes.removeLast();

    return describe;
  }

  SpecExample it(String exampleName) {
    SpecDescribe currentDescribe = _currentDescribes.last();
    if (currentDescribe != null) {
      SpecExample example = new SpecExample(exampleName);
      currentDescribe.examples.add(example);
      return example;
    } else {
      throw new UnsupportedOperationException("it() cannot be used before calling describe()");
    }
  }

}
