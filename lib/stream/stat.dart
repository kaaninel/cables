part of '../kablo.dart';

mixin InputCounter<T> on Input<T> {
  int inputCount = 0;
  final StreamController<int> _inputCount = StreamController<int>();
  Stream<int> get inputCounts => _inputCount.stream;

  void initInputCounter() =>
      inputStream.stream.map((_) => ++inputCount).forEach(_inputCount.add);
}
mixin OutputCounter<T> on Output<T> {
  int outputCount = 0;
  final StreamController<int> _outputCount = StreamController<int>();
  Stream<int> get outputCounts => _outputCount.stream;

  void initOutputCounter() =>
      outputStream.stream.map((_) => ++outputCount).forEach(_outputCount.add);
}

mixin Lag<T> on InputCounter<T>, OutputCounter<T>, Passthrough<T> {
  int _lag = 0;
  final StreamController<int> _lags = StreamController<int>();
  int get lag => _lag;
  Stream<int> get lags => _lags.stream;

  void initLag() => inputCounts
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
        InputLogger<T>,
        Lag<T>,
        Output<T> {
  Pipe({List<LogConfig<T>>? loggers}) {
    initInputCounter();
    initOutputCounter();
    initLag();
    if (kDebugMode && loggers != null) loggers.forEach(inputLogger);
    initPassthrough();
  }
}
