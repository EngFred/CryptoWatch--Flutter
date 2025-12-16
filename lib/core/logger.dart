import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@singleton
class AppLogger {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls if stacktrace is provided
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      // ignore: deprecated_member_use
      printTime: false, // Should each log print contain a timestamp
    ),
  );

  void debug(dynamic message) => _logger.d(message);

  void info(dynamic message) => _logger.i(message);

  void warning(dynamic message) => _logger.w(message);

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
