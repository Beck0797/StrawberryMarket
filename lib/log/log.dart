import 'package:flutter/foundation.dart';

class Log {
  static void info(Object msg) {
    if (kDebugMode) {
      print('${DateTime.now()} I: $msg');
    }
  }

  static void debug(Object msg) {
    if (true || kDebugMode) {
      print('${DateTime.now()} D: $msg');
    }
  }

  static void error(Object msg) {
    print('${DateTime.now()} E: $msg');
  }
}
