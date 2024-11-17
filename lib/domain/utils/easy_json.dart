
import 'package:flutter/material.dart';

class EasyJson<M> {
  Map<String?, dynamic> _serializedJson;
  M? _model;

  EasyJson(this._model, [this._serializedJson = const {}]);

  EasyJson<M> setJson(Map<String, dynamic> json) {
    _serializedJson = json;

    return this;
  }

  T? _getValue<T extends Object>(
      String? key,
      T? Function(dynamic value) logic
  ) {
    try {
      var paths = key?.contains(".") == true ? key?.split(".") : [key];
      Object tmp = _serializedJson;
      String? currentPath;

      if (paths?.length == 1) {
        return logic(_serializedJson[paths?.first]);
      } else {
        for (int i = 0; i < paths!.length; i++) {
          currentPath = paths[i];
          if (tmp is Map) {
            if (tmp.containsKey(currentPath) == false) return logic(null);
            tmp = tmp[currentPath];
          } else if (tmp is List) {
            var idx = int.tryParse(currentPath ?? "");
            if (idx != null && idx <= tmp.length-1) {
              tmp = tmp[idx];
            }
          }
        }

        return logic(tmp);
      }
    } on TypeError {
      //debugPrint("type-error ${e.stackTrace}");
      //logic(null);
    } catch (e) {
      //debugPrint("error $e");
      //logic(null);
    }
    return null;
  }

  EasyJson<M> retrieve(String? path,
      {M Function(bool value, M model)? ifBoolean,
      M Function(int value, M model)? ifInt,
      M Function(double value, M model)? ifDouble,
      M Function(List<dynamic> value, M model)? ifList,
      M Function(Map<dynamic, dynamic> value, M model)? ifMap,
      M Function(String value, M model)? ifString}) {

    try {
      if (ifBoolean != null) {
        var value = _getValue<bool>(
          path,
              (value) => bool.tryParse("$value"),
        );
        if (value != null) {
          _model = ifBoolean.call(value, _model as M);
        }
      }

      if (ifInt != null) {
        var value1 = _getValue<int>(
          path,
              (value) => int.tryParse("$value"),
        );
        if (value1 != null) {
          _model = ifInt.call(value1, _model as M);
        }
      }

      if (ifDouble != null) {
        var value2 = _getValue<double>(
          path,
              (value) => double.tryParse("$value"),
        );
        if (value2 != null) {
          _model = ifDouble.call(value2, _model as M);
        }
      }

      if (ifList != null) {
        var value3 = _getValue<List<dynamic>>(path, (value) {
          if (value.runtimeType != List<dynamic>) return [];
          return value;
        });
        if (value3 != null) {
          _model = ifList.call(value3, _model as M);
        }
      }

      if (ifMap != null) {
        var value4 = _getValue<Map<dynamic, dynamic>>(path, (value) {
          return value;
        });
        if (value4 != null) {
          _model = ifMap.call(value4, _model as M);
        }
      }

      if (ifString != null) {
        var value5 = _getValue<String>(path, (value) => value);
        if (value5 != null) {
          _model = ifString.call(value5, _model as M);
        }
      }
    } catch (e) {
      debugPrint("error in callback: ${e.toString()}");
    }


    return this;
  }

  M done() {
    return _model!;
  }
}
