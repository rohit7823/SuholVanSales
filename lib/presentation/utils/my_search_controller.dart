import 'dart:async';

import 'package:rxdart/rxdart.dart';

class MySearchController {
  String _query = "";
  static String clearPredictions = "CLEAR";

  //Function(String)? callback;
  final StreamController<String> _inputsController = StreamController();

  StreamSubscription<String>? listen(void Function(String)? onData,
          {Duration duration = const Duration(milliseconds: 600)}) =>
      _inputsController.stream.debounceTime(duration).listen(onData);

  set query(String value) {
    _query = value;
    //callback?.call(value);
    if (value.isNotEmpty) {
      _inputsController.add(value);
    }
    if (value.isEmpty) {
      _inputsController.add(clearPredictions);
    }
  }

  void flush() {
    if (_query.isNotEmpty) {
      var value = _query;
      _query = "";
      //callback?.call(value);
      _inputsController.close();
    }
  }
}
