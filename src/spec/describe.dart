// Represents a 'describe' block inside a Spec
class SpecDescribe {

  // The Spec that this describe is in
  Spec spec;

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

  SpecDescribe([Spec spec = null, String subject = null, Function fn = null]) {
    this.spec      = spec;
    this.subject   = subject;
    this.fn        = fn;
    this.examples  = new List<SpecExample>();
    this.describes = new List<SpecDescribe>();
    this.befores   = new List();
    this.afters    = new List();
  }

  // Evaluates this describe's function, if not already evaluated
  void evaluate() {
    if (! _evaluatedFn) {
      _evaluatedFn = true;
      if (fn != null) fn();
    }
  }

  // Runs all of the examples in the describe
  void run() {
    examples.forEach((example) {
      befores.forEach((fn) => fn());
      example.run();
      afters.forEach((fn) => fn());
    });
    describes.forEach((desc) => desc.run());
  }
}
