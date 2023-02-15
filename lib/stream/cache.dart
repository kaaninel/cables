part of '../kablo.dart';

mixin ValueCache<T> {
  T? value;

  Future<T> get firstNotNull;
  Future<T> get next async => value ?? await firstNotNull;

  bool get isNull => value == null;
  bool get isNotNull => !isNull;
}

mixin CacheInput<T> on Input<T>, ValueCache<T> {
  @override
  Future<T> get firstNotNull => _input.stream.where((e) => e != null).first;

  void initCacheInput() => _input.stream.forEach((e) => value = e);
}

mixin CacheOutput<T> on Output<T>, ValueCache<T> {
  @override
  Future<T> get firstNotNull => where((e) => e != null).first;

  void initCacheOutput() => _output.stream.forEach((e) => value = e);
}

mixin HasDataInput<T> on ValueCache<T>, InputCounter<T> {
  bool get hasData => inputCount > 0;
}

mixin HasDataOutput<T> on ValueCache<T>, OutputCounter<T> {
  bool get hasData => outputCount > 0;
}

class Snapshot<T> extends Stream<T?>
    with
        Input<T?>,
        Output<T?>,
        Processor<T?, T?>,
        Logger<T?>,
        ValueCache<T?>,
        CacheInput<T?>,
        InputCounter<T?>,
        HasDataInput<T?> {
  Snapshot({List<LogConfig<T>>? loggers}) {
    initInputCounter();
    initCacheInput();
    initProcessor();
    if (loggers != null) loggers.forEach(addLogger);
  }

  Pipe<T> whereNotNull() =>
      Pipe<T>()..addStream(where((event) => event != null).cast<T>());
  // ignore: prefer_void_to_null
  Pipe<Null> whereNull() =>
      // ignore: prefer_void_to_null
      Pipe<Null>()..addStream(where((event) => event == null).cast<Null>());

  Stream<T?> get output async* {
    yield value;
    yield* _input.stream;
  }

  @override
  Stream<T?> processor(Stream<T?> input) async* {
    yield value;
    yield* input;
  }
}
