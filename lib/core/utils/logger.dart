import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(dynamic message, {LogLevel level = LogLevel.info}) {
    if (kDebugMode) {
      switch (level) {
        case LogLevel.info:
          print('ℹ️ $message');
          break;
        case LogLevel.warning:
          print('⚠️ $message');
          break;
        case LogLevel.error:
          print('❌ $message');
          break;
        case LogLevel.debug:
          print('🐛 $message');
          break;
      }
    }
  }
}

enum LogLevel {
  info,
  warning,
  error,
  debug,
}