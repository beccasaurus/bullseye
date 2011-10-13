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

  // describe() should be called from within your spec() 
  // function definition.
  //
  // subject: Description of what you're describing, eg. "Dog"
  // fn:      An anonymous function with calls to it(), before(), etc
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

  // it() should be called from within a function that you pass 
  // to describe().
  //
  // name: The name of this example, eg. "should be awesome"
  // fn:   An anonymous function that has your expectations. 
  //       If fn isn't passed, the it will be marked pending; 
  SpecExample it([String name = null, var fn = null]) {
    SpecDescribe currentDescribe = _currentDescribes.last();
    if (currentDescribe != null) {
      SpecExample example = new SpecExample(name, fn);
      currentDescribe.examples.add(example);
      return example;
    } else {
      throw new UnsupportedOperationException("it() cannot be used before calling describe()");
    }
  }

  // Runs all of the describes in this spec
  run() {
    describes.forEach((desc) => desc.run());
  }
}
