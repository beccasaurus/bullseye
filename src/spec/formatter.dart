class SpecFormatter {

  String indentString;

  Function _loggingFunction;

  SpecFormatter() {
    if (indentString == null)
      indentString = "  ";
  }

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

  void write(String text, [int indent = 0]) {
    if (printToStdout != false)
      print(_indent(indent, text));

    if (_loggingFunction != null)
      _loggingFunction(_indent(indent, text) + "\n");
  }

  String _indent(int indent, String text) {
    String prefix = "";
    for (int i = 0; i < indent; i++)
      prefix += indentString;
    return prefix + text;
  }
}
