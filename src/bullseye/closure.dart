class BullseyeClosure {

  BullseyeTestFixture parent;
  static bool closuresThrowExceptions = false;
  String description;
  Function fn;
  var returnValue;
  int timeItTookToRunInUs;
  BullseyeMagicMap meta;
  Exception exception;
  var stackTrace;
  bool throwExceptions;

  StopWatch _stopWatch;
  String    _status;
  bool      _run;

  BullseyeClosure([
     String description = null, Function fn = null, Map<String,Object> meta = null, 
     Iterable<String> tags = null, String tag = null, BullseyeTestFixture parent = null]) 
  {
    this.fn        = fn;
    this.description     = description;
    this.meta            = new BullseyeMagicMap(meta);
    this.parent          = parent;
    this.throwExceptions = false;
    this._run            = false;

    if (tags != null) this.tags = tags;
    if (tag  != null) this.tags.insertRange(0, 1, tag);
  }

  List<BullseyeTestFixture> get parents() {
    List<BullseyeTestFixture> allParents = (parent == null) ? new List<BullseyeTestFixture>() : parent.parents;
    if (parent != null) allParents.add(parent);
    return allParents;
  }

  String get fullDescription() {
    String desc = (parent == null) ? "" : parent.fullDescription;
    if (description != null) {
      if (desc.length > 0)
        desc += " ";
      desc = desc + description;
    }
    return desc;
  }

  bool get passed()  => status == BullseyeTestStatus.passed;
  bool get failed()  => status == BullseyeTestStatus.failed;
  bool get error()   => status == BullseyeTestStatus.error;
  bool get pending() => status == BullseyeTestStatus.pending;

  String get pendingReason() {
    if (status == BullseyeTestStatus.pending && exception is BullseyePendingException)
      return exception.toString();
    else
      return null;
  }

  void rerun() {
    _run       = false;
    exception  = null;
    stackTrace = null;
    run();
  }

  void run() {
    if (fn == null) return;
    if (_run == true)
      throw new UnsupportedOperationException("This cannot be run() more than once.  Try rerun() to explicitly run again.");

    _run = true;

    if (throwExceptions == true || closuresThrowExceptions == true) {
      _startTimer();
      returnValue = fn();
      _stopTimerAndRecordDuration();
      _status = BullseyeTestStatus.passed;
    } else {
      try {
        _startTimer();
        returnValue = fn();
        _status = BullseyeTestStatus.passed;
      } catch (ExpectException ex, var trace) {
        _status    = BullseyeTestStatus.failed;
        exception  = ex;
        stackTrace = trace;
      } catch (BullseyePendingException ex, var trace) {
        _status    = BullseyeTestStatus.pending;
        exception  = ex;
        stackTrace = trace;
      } catch (Exception ex, var trace) {
        _status    = BullseyeTestStatus.error;
        exception  = ex;
        stackTrace = trace;
      } finally {
        _stopTimerAndRecordDuration();
      }
    }
  }

  String get status() {
    if (_status != null)
      return _status;
    else if (fn == null)
      return BullseyeTestStatus.pending;
    else
      return BullseyeTestStatus.not_run;
  }

  Iterable<String> get tags() {
    if (meta["tags"] == null)
      meta["tags"] = new List<String>();
    return meta["tags"];
  }

  void set tags(List<String> values){ meta["tags"] = values; }

  void setMeta(Map<String,Object> metaData) {
    meta.map = metaData;
  }

  void _startTimer() {
    if (_stopWatch == null)
      _stopWatch = new StopWatch();
    _stopWatch.start();
  }

  void _stopTimerAndRecordDuration() {
    _stopWatch.stop();
    timeItTookToRunInUs = _stopWatch.elapsedInUs();
  }
}
