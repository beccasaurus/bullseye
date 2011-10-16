// Represents a 'describe' block inside a Spec
class SpecDescribe {

  static List<Function> _beforeFunctions;
  static List<Function> _afterFunctions;

  // Registers the given callback so it will be 
  // fired every time any SpecDescribe is run()
  static void beforeRun(Function callback) => _beforeFunctions.add(callback);

  // Registers the given callback so it will be 
  // fired after every time any SpecDescribe is run()
  static void afterRun(Function callback) => _afterFunctions.add(callback);

  // The Spec that this describe is in
  Spec spec;

  // The describe that this is a child of, if any, as describes can be nested.
  // If this is null, then this describe was defined directly in spec().
  SpecDescribe parent;

  // The subject that we're describing, eg. "Dog"
  String subject;

  // The anonymous function passed to this describe, 
  // representing its code body.  You should call 
  // it() inside of this function to add examples 
  // to this SpecDescribe.
  Function fn;

  // All of the examples associated with this describe, 
  // added by making calls to it().
  List<SpecExample> examples;

  // All of the SpecDescribe defined in this SpecDescribe. 
  // These are created when describe() is called from within 
  // the fn passed to another SpecDescribe.
  List<SpecDescribe> describes;

  // All of the before() callbacks
  List befores;

  // All of the after() callbacks
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

  // Evaluates this describe's function, if not already evaluated
  void evaluate() {
    if (_evaluatedFn != true) {
      _evaluatedFn = true;
      if (fn != null) fn();
    }
  }

  // Returns a list of all of this describe's parent 
  // describes with the outermost describes first.
  List<SpecDescribe> get parentDescribes() {
    if (_parentDescribes == null) {

      List<SpecDescribe> tempDescribes = new List<SpecDescribe>();
      SpecDescribe       currentParent = parent;

      while (currentParent != null) {
        tempDescribes.add(currentParent);
        currentParent = currentParent.parent;
      }

      // insertRange isn't implemented yet, so we had to add each 
      // describe to the end of a temporary array.  now we'll insert 
      // them into the real array we want to return, in reverse.
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

  // Runs all of the examples in the describe
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
