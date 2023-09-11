import 'dart:io' as io;
import 'package:logger/logger.dart';

mixin AppLogger {
  static void write(String text, {bool isError = false}) {
    var logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,

          printEmojis: false,
          printTime: false,
          noBoxingByDefault: false),
    );
    logger.d(text);
  }
}
