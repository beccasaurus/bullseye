class Spec {
  
  static final VERSION = "0.1.0";

  static List<Function> _beforeFunctions;
  static List<Function> _afterFunctions;

  static void beforeRun(Function callback) => _beforeFunctions.add(callback);

  static void afterRun(Function callback) => _afterFunctions.add(callback);

  List<SpecDescribe> describes;

  List<SpecDescribe> _currentDescribes;

  Spec() {
    if (_beforeFunctions == null) _beforeFunctions = new List<Function>();
    if (_afterFunctions == null)  _afterFunctions = new List<Function>();

    describes         = new List<SpecDescribe>();
    _currentDescribes = new List<SpecDescribe>();
    spec();
  }

  void spec() {}

  SpecDescribe describe([String subject = null, Function fn = null]) {
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

  SpecExample it([String name = null, Function fn = null]) {
    SpecDescribe desc = _getCurrentDescribe("it");
    SpecExample example = new SpecExample(describe: desc, name: name, fn: fn);
    desc.examples.add(example);
    return example;
  }

  void pending([String message = "PENDING"]) {
    throw new SpecPendingException(message);
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

  void before([Function fn = null]) {
    _getCurrentDescribe("before").befores.add(fn);
  }

  void after([Function fn = null]) {
    _getCurrentDescribe("after").afters.add(fn);
  }

  void run() {
    _beforeFunctions.forEach((fn) => fn(this));
    describes.forEach((desc) => desc.run());
    _afterFunctions.forEach((fn) => fn(this));
  }
}
