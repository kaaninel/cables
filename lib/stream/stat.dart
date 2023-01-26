part of '../kablo.dart';

mixin InputCounter<T> on Input<T> {
  int inputCount = 0;
  final StreamController<int> _inputCount = StreamController<int>();
  Stream<int> get inputCounts => _inputCount.stream;

  void _initInputCounter() =>
      _input.stream.map((_) => ++inputCount).forEach(_inputCount.add);
}
mixin OutputCounter<T> on Output<T> {
  int outputCount = 0;
  final StreamController<int> _outputCount = StreamController<int>();
  Stream<int> get outputCounts => _outputCount.stream;

  void _initOutputCounter() =>
      _output.stream.map((_) => ++outputCount).forEach(_outputCount.add);
}

mixin Lag<T> on InputCounter<T>, OutputCounter<T>, Passthrough<T> {
  int _lag = 0;
  final StreamController<int> _lags = StreamController<int>();
  int get lag => _lag;
  Stream<int> get lags => _lags.stream;

  void _initLag() => inputCounts
      .merge(outputCounts)
      .map((_) => _lag = inputCount - outputCount)
      .forEach(_lags.add);
}

class Pipe<T> extends Stream<T>
    with
        Input<T>,
        Output<T>,
        Passthrough<T>,
        InputCounter<T>,
        OutputCounter<T>,
        Logger<T>,
        Lag<T>,
        Output<T> {
  Pipe({List<LogConfig<T>>? loggers}) {
    _initInputCounter();
    _initOutputCounter();
    _initLag();
    if (loggers != null) loggers.forEach(addLogger);
    _initPassthrough();
  }
}
