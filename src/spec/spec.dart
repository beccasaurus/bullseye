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
    SpecExample example = new SpecExample(name, fn);
    _getCurrentDescribe("it").examples.add(example);
    return example;
  }

  SpecDescribe _getCurrentDescribe([String callerFunctionName = null]) {
    SpecDescribe currentDescribe = _currentDescribes.last();
    if (currentDescribe != null) {
      return currentDescribe;
    } else {
      if (callerFunctionName != null)
        throw new UnsupportedOperationException("it${callerFunctionName} cannot be used before calling describe()");
    }
  }

  // Before each it() is evaluated, the before() function 
  // will be called, if provided.
  //
  // NOTE: When using nested describe(), the outer parents' 
  //       before() functions are called before the childrens'.
  void before([var fn = null]) {
    _getCurrentDescribe("before").befores.add(fn);
  }

  // After each it() is evaluated, the after() function 
  // will be called, if provided.
  //
  // NOTE: When using nested describe(), the outer parents' 
  //       after() functions are called after the childrens'.
  void after([var fn = null]) {
    _getCurrentDescribe("after").afters.add(fn);
  }

  // Runs all of the describes in this spec
  run() {
    describes.forEach((desc) => desc.run());
  }
}
