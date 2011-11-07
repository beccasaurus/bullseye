class BullseyeMagicMap {

  Map<String,Object> map;

  bool throwExceptionUnlessMapContainsKey;

  String get something() => "hi";

  BullseyeMagicMap([Map<String,Object> map = null, bool throwExceptionUnlessMapContainsKey = false, Iterable<String> allowed = null]) {
    this.throwExceptionUnlessMapContainsKey = throwExceptionUnlessMapContainsKey;
    this.map = (map == null) ? new LinkedHashMap<String,Object>() : map;

    if (allowed != null)
      onlyAllow(allowed);
  }

  // Given the names of keys/properties, this will setup this MagicMap 
  // so it will throw a NoSuchMethodException if you try to get/set 
  // any "magic" properties on this besides the allowed names given.
  //
  // Note: you can still access the internal map directly and we do 
  //       nothing to prevent you from getting/setting anything on 
  //       the Map, this just effects the noSuchMethod behavior.
  //
  // Note: after running this, your Map will contain keys for each 
  //       allowed name given with the value set to null.
  void onlyAllow(Iterable<String> allowed) {
    throwExceptionUnlessMapContainsKey = true;
    for (String key in allowed) map[key] = null;
  }

  noSuchMethod(String name, List args) {
    if (name.length > 4) { // needs to have get: or set: prefix
      String prefix  = name.substring(0, 4);
      String key     = name.substring(4);

      if (throwExceptionUnlessMapContainsKey == true)
        if (! map.containsKey(key))
          super.noSuchMethod(name, args);

      if (prefix == "get:")
        return map[key];
      else if (prefix == "set:")
        map[key] = args[0];
      else
        super.noSuchMethod(name, args);
    } else {
      super.noSuchMethod(name, args);
    }
  }

  // NOTE: This only supports functions that noSuchMethod supports.
  //
  // This won't return true if you ask a MagicMap if it respondsTo("toString") even 
  // though it very obviously does!  This is just paired with our noSuchMethod implementation.
  bool respondsTo(String name) {
    if (name.length > 4) {
      String prefix  = name.substring(0, 4);
      String key     = name.substring(4);
      if (throwExceptionUnlessMapContainsKey == true)
        return map.containsKey(key);
      else if (prefix == "get:" || prefix == "set:")
        return true;
    } else {
      return false;
    }
  }
  
  // @see Map.[]
  operator [](key) => map[key];

  // @see Map.[]=
  operator []=(key, value) => map[key] = value;

  // @see Map.length
  int get length() => map.length;

  // @see Map.forEach
  void forEach(void f(String, V)){ map.forEach(f); }

  // Get the name of the key to use in the map.
  // 
  // Returns null if we don't support the given name/args 
  // and, therefore, want to pass our noSuchMethod along to super.
  _getKeyName(String name, List args) {
    return null;
  }
}
