part of '../kablo.dart';

mixin StateValue<T, Q> on Output<Q>, Disposable<T> {
  abstract Q value;

  late final StreamSubscription<Q> _stateSub;
  StreamSubscription<Q> initState() {
    return _stateSub = outputStream.stream.listen((event) {
      value = event;
    });
  }

  void disposeState() {
    _stateSub.cancel();
  }

  Stream<Q> get output async* {
    yield value;
    yield* this;
  }
}

mixin ValueCache<T> {
  T? value;

  Future<T> get firstNotNull;
  Future<T> get next async => value ?? await firstNotNull;

  bool get isNull => value == null;
  bool get isNotNull => !isNull;
}

mixin CacheInput<T> on Input<T>, ValueCache<T> {
  @override
  Future<T> get firstNotNull =>
      inputStream.stream.where((e) => e != null).first;

  void initCacheInput() => inputStream.stream.forEach((e) => value = e);
}

mixin CacheOutput<T> on Output<T>, ValueCache<T> {
  @override
  Future<T> get firstNotNull => where((e) => e != null).first;

  void initCacheOutput() => outputStream.stream.forEach((e) => value = e);
}

mixin HasDataInput<T> on ValueCache<T>, InputCounter<T> {
  bool get hasData => inputCount > 0;
}

mixin HasDataOutput<T> on ValueCache<T>, OutputCounter<T> {
  bool get hasData => outputCount > 0;
}

class Snapshot<T> extends Point<T?>
    with ValueCache<T?>, InputCounter, HasDataInput {
  Snapshot({super.loggers}) : super(null) {
    initInputCounter();
  }

  @override
  Future<T> get firstNotNull => whereNotNull().first;
  @override
  Pipe<T> whereNotNull() =>
      Pipe<T>()..addStream(where((event) => event != null).cast<T>());
}

class Point<T> extends Stream<T>
    with
        Input<T>,
        Output,
        Disposable,
        StateValue,
        Processor,
        InputLogger,
        OutputLogger {
  @override
  T value;

  Point(this.value, {List<LogConfig<T>>? loggers}) {
    initProcessor();
    initDisposable();
    if (kDebugMode && loggers != null) loggers.forEach(outputLogger);
  }

  Pipe<T> whereNotNull() =>
      Pipe<T>()..addStream(where((event) => event != null).cast<T>());

  Pipe<void> whereNull() =>
      Pipe<void>()..addStream(where((event) => event == null).cast<void>());

  @override
  Stream<T> processor(Stream<T> input) async* {
    await for (var item in input) {
      if (item == value) continue;
      value = item;
      yield item;
    }
  }

  @override
  String toString() => "Point<$T>($value)";

  @override
  void dispose() {
    disposeProcessor();
  }
}
