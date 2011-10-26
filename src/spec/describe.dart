class SpecDescribe {

  static List<Function> _beforeFunctions;
  static List<Function> _afterFunctions;

  static void beforeRun(Function callback) => _beforeFunctions.add(callback);

  static void afterRun(Function callback) => _afterFunctions.add(callback);

  Spec spec;

  SpecDescribe parent;

  String subject;

  Function fn;

  List<SpecExample> examples;

  List<SpecDescribe> describes;

  List befores;

  List afters;

  bool _evaluatedFn;
  List<SpecDescribe> _parentDescribes;

  SpecDescribe([Spec spec = null, SpecDescribe parent = null, String subject = null, Function fn = null]) {
    if (_beforeFunctions == null) _beforeFunctions = new List<Function>();
    if (_afterFunctions == null)  _afterFunctions = new List<Function>();

    this.spec      = spec;
    this.subject   = subject;
    this.fn        = fn;
    this.examples  = new List<SpecExample>();
    this.describes = new List<SpecDescribe>();
    this.befores   = new List();
    this.afters    = new List();
    this.parent    = parent;
  }

  void evaluate() {
    if (_evaluatedFn != true) {
      _evaluatedFn = true;
      if (fn != null) fn();
    }
  }

  List<SpecDescribe> get parentDescribes() {
    if (_parentDescribes == null) {

      List<SpecDescribe> tempDescribes = new List<SpecDescribe>();
      SpecDescribe       currentParent = parent;

      while (currentParent != null) {
        tempDescribes.add(currentParent);
        currentParent = currentParent.parent;
      }

      _parentDescribes = new List<SpecDescribe>();
      var times = tempDescribes.length;
      for (int i = 0; i < times; i++)
        _parentDescribes.add(tempDescribes.removeLast());
    }   
    return _parentDescribes;
  }

  void runBefores() {
    befores.forEach((fn) => fn());
  }

  void runAfters() {
    afters.forEach((fn) => fn());
  }

  void run() {
    _beforeFunctions.forEach((fn) => fn(this));
    examples.forEach((example) {
      parentDescribes.forEach((parent) => parent.runBefores());
      runBefores();
      example.run();
      runAfters();
      parentDescribes.forEach((parent) => parent.runAfters());
    });
    describes.forEach((desc) => desc.run());
    _afterFunctions.forEach((fn) => fn(this));
  }
}
