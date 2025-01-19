part of '../kablo.dart';

/// The `InputCounter` mixin is used to count the number of input events in a stream.
/// It provides a stream of input counts that can be listened to.
mixin InputCounter<T> on Input<T> {
  int inputCount = 0;
  final StreamController<int> _inputCount = StreamController<int>();
  Stream<int> get inputCounts => _inputCount.stream;

  /// Initializes the input counter by listening to the input stream and incrementing the input count.
  void initInputCounter() =>
      inputStream.stream.map((_) => ++inputCount).forEach(_inputCount.add);
}

/// The `OutputCounter` mixin is used to count the number of output events in a stream.
/// It provides a stream of output counts that can be listened to.
mixin OutputCounter<T> on Output<T> {
  int outputCount = 0;
  final StreamController<int> _outputCount = StreamController<int>();
  Stream<int> get outputCounts => _outputCount.stream;

  /// Initializes the output counter by listening to the output stream and incrementing the output count.
  void initOutputCounter() =>
      outputStream.stream.map((_) => ++outputCount).forEach(_outputCount.add);
}

/// The `Lag` mixin is used to calculate the lag between the input and output counts in a stream.
/// It provides a stream of lag values that can be listened to.
mixin Lag<T> on InputCounter<T>, OutputCounter<T>, Passthrough<T> {
  int _lag = 0;
  final StreamController<int> _lags = StreamController<int>();
  int get lag => _lag;
  Stream<int> get lags => _lags.stream;

  /// Initializes the lag calculation by merging the input and output counts and calculating the lag.
  void initLag() => inputCounts
      .merge(outputCounts)
      .map((_) => _lag = inputCount - outputCount)
      .forEach(_lags.add);
}

/// The `Pipe` class is a fundamental building block in the `kablo` library.
/// It provides a way to create a duplex stream with input and output capabilities, along with various mixins for additional functionality.
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
  /// Constructor to create a new `Pipe` instance.
  /// Optionally, you can provide a list of loggers to log the input events.
  Pipe({List<LogConfig<T>>? loggers}) {
    initInputCounter();
    initOutputCounter();
    initLag();
    if (kDebugMode && loggers != null) loggers.forEach(inputLogger);
    initPassthrough();
  }
}
