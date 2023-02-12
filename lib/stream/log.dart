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

class PrintLog<T> extends LogConfig<T> {
  final Formatter<T, String>? formatter;
  final Condition<T>? condition;

  final bool debugOnly;

  const PrintLog({
    required super.name,
    this.formatter,
    this.condition,
    this.debugOnly = true,
  });

  @override
  void onLog(T? obj) {
    if (condition == null || condition!(obj)) {
      if (!debugOnly || kDebugMode) {
        // ignore: avoid_print
        print(formatter != null ? formatter!(obj) : obj.toString());
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

mixin Logger<T> on Input<T> {
  void addLogger(LogConfig<T> config) => _input.stream.forEach(config.onLog);
}
