// Represents a single Spec
class Spec {

  // All of the SpecDescribe defined in this Spec
  List describes;

  Spec() {
    describes = new List();
    spec();
  }

  // You must override spec() in your Spec class 
  // and use it to define your spec.
  spec() {}

  describe(String subject) {
    describes.add(new SpecDescribe(subject));
  }

}
