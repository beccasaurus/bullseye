#library("dog.dart");

class Dog {
  String name, breed;
  Dog([String name = null, String breed = null]) {
    this.name = name;
    this.breed = breed;
  }
  bark() {
    return "Woof!  My name is $name";
  }
}
