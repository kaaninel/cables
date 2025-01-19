part of '../kablo.dart';

/// The `LogLevel` enum represents different levels of logging severity.
enum LogLevel { all, config, info, warning, severe, shout, off }

/// The `LogConfig` class is an abstract class that defines the configuration for logging events in a stream.
/// It provides a way to specify the name and log level for the logging configuration and requires the implementation of the `onLog` method to handle the logging of events.
abstract class LogConfig<T> {
  final String name;
  final LogLevel level;

  const LogConfig({required this.name, this.level = LogLevel.info});

  void onLog(T? obj);
}

typedef Formatter<T, Q> = Q Function(T? obj);
typedef Condition<T> = bool Function(T? obj);
typedef Sequencer<T> = int? Function(T? obj);

/// The `PrintLog` class is a type of `LogConfig` that logs objects using the `log` function.
/// It provides options for formatting, conditioning, and sequencing the log messages.
class PrintLog<T> extends LogConfig<T> {
  final Formatter<T, String>? formatter;
  final Condition<T>? condition;
  final Sequencer<T>? sequencer;

  final bool debugOnly;

  const PrintLog({
    required super.name,
    this.formatter,
    this.condition,
    this.sequencer,
    this.debugOnly = true,
  });

  String format(T? obj) => formatter != null ? formatter!(obj) : obj.toString();

  @override
  void onLog(T? obj) {
    final seq = sequencer != null ? sequencer!(obj) : null;
    if (condition == null || condition!(obj)) {
      if (!debugOnly || kDebugMode) {
        log(format(obj), time: DateTime.now(), sequenceNumber: seq, name: name);
      }
    }
  }
}

/// The `InspectLog` class is a type of `LogConfig` that uses the `inspect` function to log objects.
/// This is useful for debugging purposes, as it allows you to inspect the state of an object at a specific point in time.
class InspectLog<T> extends LogConfig<T> {
  const InspectLog({required super.name});

  @override
  void onLog(T? obj) {
    inspect(obj);
  }
}

/// The `InputLogger` mixin is used to log input events in a stream.
/// It provides a way to attach logging configurations to the input stream of a class that implements the `Input` mixin.
mixin InputLogger<T> on Input<T> {
  void inputLogger(LogConfig<T> config) =>
      inputStream.stream.forEach(config.onLog);
}

/// The `OutputLogger` mixin is used to log output events in a stream.
/// It provides a way to attach logging configurations to the output stream of a class that implements the `Output` mixin.
mixin OutputLogger<T> on Output<T> {
  void outputLogger(LogConfig<T> config) =>
      outputStream.stream.forEach(config.onLog);
}
