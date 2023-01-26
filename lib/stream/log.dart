part of '../kablo.dart';

enum LogLevel { all, config, info, warning, severe, shout, off }

class LogConfig<T> {
  final String name;
  final LogLevel level;
  final String Function(T obj)? formatter;
  final bool Function(T obj)? condition;

  const LogConfig({
    required this.name,
    this.level = LogLevel.info,
    this.formatter,
    this.condition,
  });
}

mixin Logger<T> on Input<T> {
  static String defaultFormatter<T>(T obj) => obj.toString();
  static bool defaultCondition<T>(T obj) => true;
  static void defaultAction<T>(LogConfig<T> config, T obj) =>
      // ignore: avoid_print
      print('${config.name} - $obj');

  void addLogger(LogConfig<T> config) => _input.stream
      .where(config.condition ?? defaultCondition)
      .map(config.formatter ?? defaultFormatter)
      .forEach((msg) => defaultAction(config, msg));
}
