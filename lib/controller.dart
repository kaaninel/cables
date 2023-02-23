import 'package:flutter/foundation.dart';
import 'package:kablo/kablo.dart';

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

  @override
  void dispose() {
    disposeState();
    disposeProcessor();
  }

  Stream<S> onTask(T task);

  @override
  Stream<S> processor(Stream<T> input) async* {
    await for (final task in input) {
      yield* onTask(task);
    }
  }
}
