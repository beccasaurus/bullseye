class SpecFormatter {

  static Map<String,String> _colors;

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

  bool _colorize;
  bool get colorize() {
    if (_colorize == null) _colorize = true;
    return _colorize;
  }
  void set colorize(value) => _colorize = value;

  String _indentString;

  Function _loggingFunction;

  get indentString() => "  ";

  bool printToStdout;

  void logger(Function fn) {
    _loggingFunction = fn;
  }

  void header(){}
  void footer(){}
  void beforeSpec(Spec spec){}
  void afterSpec(Spec Spec){}
  void beforeDescribe(SpecDescribe describe){}
  void afterDescribe(SpecDescribe describe){}
  void beforeExample(SpecExample example){}
  void afterExample(SpecExample example){}

  void write(String text, [int indent = 0, String color = null]) {
    var result = _indent(indent, text);
    if (colorize == true)
      result = colorizeText(result, color);
    if (printToStdout != false)
      print(result);
    if (_loggingFunction != null)
      _loggingFunction(result + "\n");
  }

  String get colorReset() => "\x1b\x5b;0;37m";

  String colorizeText([String text = null, String color = null]) {
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
