// TODO hmm ... this is just a definition class now ... should it know how to run itself?
//      I think not!  We just want to run Iterable<BullseyeTestContext>!  That's what this needs to provide!

class BullseyeTestContextDefinition implements BullseyeTestContextProvider {
  
  static final VERSION = "0.1.0"; // TODO move me!

  static List<Function> _beforeFunctions;
  static List<Function> _afterFunctions;

  static void beforeRun(Function callback) => _beforeFunctions.add(callback);

  static void afterRun(Function callback) => _afterFunctions.add(callback);

  // not implemented yet
  Iterable<SpecDescribe> get testContexts() => <SpecDescribe>[];

  List<SpecDescribe> describes;

  List<SpecDescribe> _currentDescribes;

  BullseyeTestContextDefinition() {
    if (_beforeFunctions == null) _beforeFunctions = new List<Function>();
    if (_afterFunctions == null)  _afterFunctions = new List<Function>();

    describes         = new List<SpecDescribe>();
    _currentDescribes = new List<SpecDescribe>();

    defineTestContext();
  }

  void defineTestContext(){}

  SpecDescribe defineNestedTestContext([String subject = null, Function fn = null]) {
    SpecDescribe parent   = _currentDescribes.length == 0 ? null : _currentDescribes.last();
    SpecDescribe describe = new SpecDescribe(spec: this, subject: subject, fn: fn, parent: parent);

    if (_currentDescribes.length == 0)
      describes.add(describe);
    else
      _currentDescribes.last().describes.add(describe);

    _currentDescribes.addLast(describe);
    describe.evaluate();
    _currentDescribes.removeLast();

    return describe;
  }

  SpecExample defineTest([String name = null, Function fn = null]) {
    SpecDescribe desc = _getCurrentDescribe("it");
    SpecExample example = new SpecExample(describe: desc, name: name, fn: fn);
    desc.examples.add(example);
    return example;
  }

  void pending([String message = "PENDING"]) {
    throw new SpecPendingException(message);
  }

  void defineSetUp([Function fn = null]) {
    _getCurrentDescribe("before").befores.add(fn);
  }

  void defineTearDown([Function fn = null]) {
    _getCurrentDescribe("after").afters.add(fn);
  }

  void run() {
    _beforeFunctions.forEach((fn) => fn(this));
    describes.forEach((desc) => desc.run());
    _afterFunctions.forEach((fn) => fn(this));
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
}
