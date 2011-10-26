class OriginalMagicMapSpec extends SpecMap_Bullseye {
  spec() {
    describe("MagicMap", {

      "wraps an internal Map (publicly accessible)": (){
        var magic = new BullseyeMagicMap<String, String>();
        Expect.isTrue(magic.map is Map<String, String>);
        Expect.equals(0, magic.map.length);
      },

      "can be instantiated with an existing Map": (){
        var magic = new BullseyeMagicMap<String, String>({ "hello": "world" });
        Expect.isTrue(magic.map is Map<String, String>);
        Expect.equals(1, magic.map.length);
        Expect.equals("world", magic.map["hello"]);
      },

      "lets you set a value in its map by calling a normal setter": (){
        var magic = new BullseyeMagicMap<String,String>();
        Expect.isFalse(magic.map.containsKey("foo"));

        magic.foo = "bar";

        Expect.isTrue(magic.map.containsKey("foo"));
        Expect.equals("bar", magic.map["foo"]);
      },

      "lets you get a value in its map by calling a normal getter": (){
        var magic = new BullseyeMagicMap<String,String>({ "foo": "bar" });
        Expect.equals("bar", magic.foo);
      },

      "returns null when a getter is called for a key that does not exist": (){
        Expect.isNull(new BullseyeMagicMap<String,String>().foo);
      },

      "can be configured to throw NoSuchMethodException when getter is called for missing key": (){
        var magic = new BullseyeMagicMap<String, String>();
        Expect.isNull(magic.foo);

        magic.throwExceptionUnlessMapContainsKey = true;
      
        Expect.throws(() => Expect.isNull(magic.foo), 
          check: (ex) => ex is NoSuchMethodException && ex.toString().contains("Class: BullseyeMagicMap'' function name: 'get:foo' arguments: []]", 0));
      },

      "when configured to throwExceptionUnlessMapContainsKey, an exception is not thrown if the key already exists but the value is null": (){
        var magic = new BullseyeMagicMap<String, String>();
        Expect.isNull(magic.foo);
        magic.foo = null;

        magic.throwExceptionUnlessMapContainsKey = true;
      
        Expect.isNull(magic.foo); // no boom
      },

      "can be given a List of allowed keys.  if any other key is used, a NoSuchMethodException will be thrown (basically mocking a normal class instance)": (){
        var magic = new BullseyeMagicMap<String, String>(allowed: ["foo", "bar"]);

        magic.foo = "whatever";
        magic.bar = "blah blah";
        Expect.equals("whatever", magic.foo);
        Expect.equals("blah blah", magic.bar);

        // Can't get
        Expect.throws(() => magic.somethingElse,
          check: (ex) => ex is NoSuchMethodException && ex.toString().contains("Class: BullseyeMagicMap'' function name: 'get:somethingElse' arguments: []]", 0));

        // Can't set
        Expect.throws(() => magic.somethingElse = "hi",
          check: (ex) => ex is NoSuchMethodException && ex.toString().contains("Class: BullseyeMagicMap'' function name: 'set:somethingElse' arguments: [hi]]", 0));
      },

      "delegates [](key) to Map": (){
        Expect.equals("bar", new BullseyeMagicMap<String,String>({ "foo": "bar" })["foo"]);
      },

      "delegates []=(key) to Map": (){
        var magic = new BullseyeMagicMap<String,String>();
        Expect.isNull(magic.foo);
      
        magic["foo"] = "bar";

        Expect.equals("bar", magic.foo);
      },

      "delegates length to Map": (){
        Expect.equals(2, new BullseyeMagicMap<String,int>({ "one": 1, "two": 2 }).length);
      },

      "delegates forEach to Map": (){
        var text = "";
        new BullseyeMagicMap<String,String>({ "hello": "world", "foo": "bar" }).forEach((key, value) {
          text += "$key -> $value ";
        });
        Expect.equals("hello -> world foo -> bar ", text);
      },

      "doesn't catch method calls, only catches property get/set calls": (){
        var magic = new BullseyeMagicMap<String,String>({ "foo": "bar" });

        Expect.equals("bar", magic.foo);

        Expect.throws(() => Expect.equals("bar", magic.foo()), 
          check: (ex) => ex is NoSuchMethodException && ex.toString().contains("Class: BullseyeMagicMap'' function name: 'foo' arguments: []]", 0));
      },

      "can see if a MagicMap respondsTo('keyName') so you can more easily prevent a NoSuchMethodException being thrown": (){
        var magic = new BullseyeMagicMap<String,String>();
        Expect.isTrue(magic.respondsTo("get:foo"));
        Expect.isTrue(magic.respondsTo("get:bar"));
        
        // Ok, but now, let's only allow 'foo'
        magic.onlyAllow(["foo"]);

        Expect.isTrue(magic.respondsTo("get:foo"));
        Expect.isFalse(magic.respondsTo("get:bar"));

        // Just to be sure that respondsTo is reporting what we expect, let's try to actually call each
        Expect.isNull(magic.foo);

        Expect.throws(() => Expect.isNull(magic.bar),
          check: (ex) => ex is NoSuchMethodException && ex.toString().contains("Class: BullseyeMagicMap'' function name: 'get:bar' arguments: []]", 0));
      }

      // If you want to use any other Map functions, you should call the internal Map directly (atleast for now)

    });
  }
}
