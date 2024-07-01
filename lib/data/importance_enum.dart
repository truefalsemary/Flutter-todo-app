import 'package:flutter/cupertino.dart';
import 'package:flutter_todo_app/utils/app_localization_context_ext.dart';

enum Importance {
  low,
  basic,
  important;

  parseToString([BuildContext? context]) {
    final appLn = context?.appLn;
    switch (this) {
      case Importance.low:
        return appLn == null ? 'no' : appLn.importanceNo;
      case Importance.basic:
        return appLn == null ? 'low' : appLn.importanceLow;
      case Importance.important:
        return appLn == null ? 'high' : appLn.importanceHigh;
    }
  }

  static Importance fromString(String importance) {
    if (importance == 'no') {
      return Importance.low;
    } else if (importance == 'low') {
      return Importance.basic;
    } else {
      return Importance.important;
    }
  }
}
