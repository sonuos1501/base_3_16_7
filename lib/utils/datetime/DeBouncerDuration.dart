// ignore_for_file: avoid_dynamic_calls, use_late_for_private_fields_and_variables, file_names

import 'dart:async';

class DeBouncerDuration {

  DeBouncerDuration({this.delay = const Duration(milliseconds: 500)});
  Duration delay;
  Timer? _timer;
  Function? _callback;

  void debounce(Function callback) {
    _callback = callback;

    cancel();
    _timer = Timer(delay, flush);
  }

  void cancel() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void flush() {
    _callback!();
    cancel();
  }
}
