part of '../kablo.dart';

/// The `StateValue` mixin is used to manage the state of an output stream.
/// It listens to the output stream and updates the `value` property with the latest event.
mixin StateValue<T, Q> on Output<Q>, Disposable<T> {
  abstract Q value;

  late final StreamSubscription<Q> _stateSub;

  /// Initializes the state by listening to the output stream and updating the `value` property.
  StreamSubscription<Q> initState() {
    return _stateSub = outputStream.stream.listen((event) {
      value = event;
    });
  }

  /// Disposes of the state by canceling the stream subscription.
  void disposeState() {
    _stateSub.cancel();
  }

  /// Returns a stream that yields the current value followed by the output stream events.
  Stream<Q> get output async* {
    yield value;
    yield* this;
  }
}

/// The `ValueCache` mixin is used to cache the latest value of a stream.
/// It provides methods to access the cached value and check if it is null.
mixin ValueCache<T> {
  T? value;

  Future<T> get firstNotNull;
  Future<T> get next async => value ?? await firstNotNull;

  bool get isNull => value == null;
  bool get isNotNull => !isNull;
}

/// The `CacheInput` mixin is used to cache the latest input value of a stream.
/// It updates the `value` property with the latest input event.
mixin CacheInput<T> on Input<T>, ValueCache<T> {
  @override
  Future<T> get firstNotNull =>
      inputStream.stream.where((e) => e != null).first;

  void initCacheInput() => inputStream.stream.forEach((e) => value = e);
}

/// The `CacheOutput` mixin is used to cache the latest output value of a stream.
/// It updates the `value` property with the latest output event.
mixin CacheOutput<T> on Output<T>, ValueCache<T> {
  @override
  Future<T> get firstNotNull => where((e) => e != null).first;

  void initCacheOutput() => outputStream.stream.forEach((e) => value = e);
}

/// The `HasDataInput` mixin is used to check if the input stream has received any data.
/// It provides a `hasData` property that returns `true` if the input count is greater than zero.
mixin HasDataInput<T> on ValueCache<T>, InputCounter<T> {
  bool get hasData => inputCount > 0;
}

/// The `HasDataOutput` mixin is used to check if the output stream has emitted any data.
/// It provides a `hasData` property that returns `true` if the output count is greater than zero.
mixin HasDataOutput<T> on ValueCache<T>, OutputCounter<T> {
  bool get hasData => outputCount > 0;
}

/// The `Snapshot` class is a type of `Point` that caches the latest value and provides additional functionality.
/// It extends `Point` with `ValueCache`, `InputCounter`, and `HasDataInput` mixins.
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

/// The `Point` class is a stream that maintains the latest value and provides various mixins for additional functionality.
/// It combines `Input`, `Output`, `Disposable`, `StateValue`, `Processor`, `InputLogger`, and `OutputLogger` mixins.
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

  /// Returns a `Pipe` that filters out null values from the stream.
  Pipe<T> whereNotNull() =>
      Pipe<T>()..addStream(where((event) => event != null).cast<T>());

  /// Returns a `Pipe` that filters out non-null values from the stream.
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
