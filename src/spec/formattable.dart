// The Formattable interface represents a class 
// that is capable of formatting output for a 
// spec suite, specifically when run via Specs.run()
interface SpecFormattable {

  // Called at the start of the spec suite
  void header();

  // Called at the end of the spec suite
  void footer();

  // Called before running each Spec.
  // See: Spec.beforeRun()
  void beforeSpec(Spec spec);

  // Called after running each Spec.
  // See: Spec.afterRun()
  void afterSpec(Spec spec);

  // Called before running each SpecDescribe.
  // See: SpecDescribe.beforeRun()
  void beforeDescribe(SpecDescribe describe);

  // Called after running each SpecDescribe.
  // See: SpecDescribe.afterRun()
  void afterDescribe(SpecDescribe describe);

  // Called before running each SpecExample.
  // See: SpecExample.beforeRun()
  void beforeExample(SpecExample describe);

  // Called after running each SpecExample.
  // See: SpecExample.afterRun()
  void afterExample(SpecExample describe);

}
