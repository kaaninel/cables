part of '../kablo.dart';

enum LogLevel { all, config, info, warning, severe, shout, off }

abstract class LogConfig<T> {
  final String name;
  final LogLevel level;

  const LogConfig({required this.name, this.level = LogLevel.info});

  void onLog(T? obj);
}

typedef Formatter<T, Q> = Q Function(T? obj);
typedef Condition<T> = bool Function(T? obj);
typedef Sequencer<T> = int? Function(T? obj);

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

class InspectLog<T> extends LogConfig<T> {
  const InspectLog({required super.name});

  @override
  void onLog(T? obj) {
    inspect(obj);
  }
}

mixin InputLogger<T> on Input<T> {
  void inputLogger(LogConfig<T> config) =>
      inputStream.stream.forEach(config.onLog);
}

mixin OutputLogger<T> on Output<T> {
  void outputLogger(LogConfig<T> config) =>
      outputStream.stream.forEach(config.onLog);
}
