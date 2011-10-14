// Implementation of SpecFormattable that can be used as 
// a base class to simplify SpecFormattable implementation.
class SpecFormatter implements SpecFormattable {

  static Map<String,String> _colors;
         bool               _colorize;
         Function           _loggingFunction;

  // A Map of color names, eg. "white" to escape 
  // sequences for creating colored output.
  static Map<String,String> get colors() {
    if (_colors == null)
      _colors = {
        "white":  "\x1b\x5b;0;37m",
        "red":    "\x1b\x5b;0;31m",
        "green":  "\x1b\x5b;0;32m",
        "yellow": "\x1b\x5b;0;33m"
      };
    return _colors;
  }

  // Empty SpecFormattable implementation
  void header(){}
  void footer(){}
  void beforeSpec(Spec spec){}
  void afterSpec(Spec Spec){}
  void beforeDescribe(SpecDescribe describe){}
  void afterDescribe(SpecDescribe describe){}
  void beforeExample(SpecExample example){}
  void afterExample(SpecExample example){}

  // Whether or not this formatter should print 
  // all of its output to STDOUT (via print())
  bool printToStdout;

  // Returns the String that this formatter uses  
  // when indenting content.  See write().
  String get indentString() => "  ";

  // Returns a color escape sequence for resetting 
  // colored text back to the default color.
  // NOTE: right now, this just sets the color to white.
  String get colorReset() => "\x1b\x5b;0;37m";

  // Returns whether or not this formatter 
  // should colorize output.
  bool get colorize() {
    if (_colorize == null) _colorize = true;
    return (_colorize == true);
  }

  // See colorize()
  set colorize(bool value) => _colorize = value;

  // TODO how should the arguments be .. void f(String text) ...?
  // Registers a function with this formatter. 
  // The function you provide will be called every 
  // time output is written via write(),
  void logger(Function fn) {
    _loggingFunction = fn;
  }

  // Writes the given text out to STDOUT and/or functions 
  // registered via logger().
  //
  // indent: the number of levels deep you would like this text indented
  // color:  the name of a color to print this text as (from colors())
  void write(String text, [int indent = 0, String color = null]) {
    String result = _indent(indent, text);
    if (colorize == true)
      result = _colorizeText(result, color);
    if (printToStdout != false)
      print(result);
    if (_loggingFunction != null)
      _loggingFunction(result + "\n");
  }

  String _colorizeText([String text = null, String color = null]) {
    if (color == null)
      return text;
    else
      return "${colors[color]}${text}${colorReset}";
  }

  String _indent(int indent, String text) {
    String prefix = "";
    for (int i = 0; i < indent; i++)
      prefix += indentString;
    return prefix + text;
  }
}
