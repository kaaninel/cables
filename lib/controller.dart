import 'package:flutter/foundation.dart';
import 'package:kablo/kablo.dart';

/// The `Controller` class is an abstract class that extends `Stream` and is a key component of the library.
/// It is designed to manage the flow of data between input and output streams, providing various mixins for additional functionality.
abstract class Controller<T, S> extends Stream<S>
    with
        Input<T>,
        Output<S>,
        Disposable<T>,
        Processor,
        StateValue,
        InputLogger,
        OutputLogger,
        Waiter,
        InputCounter,
        OutputCounter {
  @override
  late S value;

  /// Constructor to initialize the `Controller` with an initial state value and optional input and output log configurations.
  Controller(this.value,
      {List<LogConfig<T>>? inputLogs, List<LogConfig<S>>? outputLogs}) {
    initDisposable();
    initInputCounter();
    initOutputCounter();
    initState();
    initWaiter(initProcessor().inputSub);
    if (kDebugMode) {
      if (inputLogs != null) inputLogs.forEach(inputLogger);
      if (outputLogs != null) outputLogs.forEach(outputLogger);
    }
  }

  /// Disposes of the resources used by the `Controller`.
  @override
  void dispose() {
    disposeState();
    disposeProcessor();
    close();
  }

  /// Abstract method to process a task and return a stream of output values.
  Stream<S> onTask(T task);

  /// Processes the input stream and yields the output stream.
  @override
  Stream<S> processor(Stream<T> input) async* {
    await for (final task in input) {
      yield* onTask(task);
    }
  }
}
