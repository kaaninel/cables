part of '../kablo.dart';

class Aggragate<K, V> extends Stream<Map<K, V>>
    with
        Input<MapEntry<K, V?>>,
        Disposable,
        Output,
        OutputCounter,
        Waiter,
        InputLogger,
        ValueCache<Map<K, V>>,
        HasDataOutput,
        CacheOutput,
        Processor {
  Aggragate({List<LogConfig<MapEntry<K, V?>>>? loggers}) {
    if (loggers != null) loggers.forEach(inputLogger);
    initOutputCounter();
    initCacheOutput();
    initDisposable();
    initWaiter(initProcessor().inputSub);
  }

  Map<K, V> _state = {};

  @override
  processor(input) async* {
    await for (final entry in input) {
      if (entry.value == null) {
        _state.remove(entry.key);
      } else {
        _state[entry.key] = entry.value as V;
      }
      yield _state;
    }
  }

  Stream<List<V>> asList() => map((event) => event.values.toList());
  Stream<Set<V>> asSet() => map((event) => event.values.toSet());

  void clear() => _state = {};

  static Aggragate<int, V> fromStreams<V>(List<Stream<V>> streams) {
    var collector = Aggragate<int, V>();
    StreamGroup.merge(streams.asMap().entries.map(
            (entry) => entry.value.map((event) => MapEntry(entry.key, event))))
        .forEach(collector.add);
    return collector;
  }

  @override
  void dispose() {
    disposeProcessor();
  }
}

class Merge<T> extends Stream<T>
    with
        Input<T>,
        Output,
        InputCounter,
        OutputCounter,
        Passthrough,
        Waiter,
        InputLogger {
  Merge({List<LogConfig<T>>? loggers}) {
    if (loggers != null) loggers.forEach(inputLogger);
    initInputCounter();
    initOutputCounter();
    initWaiter(initPassthrough());
  }

  final FutureGroup<void> _blockers = FutureGroup<void>();

  Future<void> addSource(Stream<T> source,
      {bool blocking = false, bool wait = true}) async {
    if (blocking) {
      if (wait && !_blockers.isIdle) await _blockers.onIdle.first;
      _blockers.add(inputStream.addStream(source));
    } else {
      addStream(source);
    }
  }

  static Merge<T> fromList<T>(Iterable<Stream<T>> inputs) {
    var instance = Merge<T>();
    inputs.forEach(instance.addSource);
    return instance;
  }
}

class GroupBy<K, V> extends Stream<Map<K, List<V>>>
    with
        Input<V>,
        Output,
        InputCounter,
        InputLogger,
        ValueCache<Map<K, List<V>>>,
        CacheOutput,
        Waiter {
  final Stream<K> Function(V e) builder;
  GroupBy({List<LogConfig<V>>? loggers, required this.builder}) {
    if (loggers != null) loggers.forEach(inputLogger);
    initInputCounter();
    initCacheOutput();
    initWaiter(_merger.listen(outputStream.add));
    initGroupBy();
  }

  final Merge<Map<K, List<V>>> _merger = Merge();

  final Map<K, List<V>> _state = {};
  final Map<V, K> _reverseLookupTable = {};
  final Map<K, V> _lookupTable = {};

  void initGroupBy() =>
      inputStream.stream.map(_builderStream).forEach(_merger.addSource);

  final Map<V, Stream<K>> _streams = {};
  Stream<Map<K, List<V>>> _builderStream(V obj) {
    if (_streams.containsKey(obj)) return const Stream.empty();
    return builder(obj)
        .expand((key) => _diffEntries(key, obj))
        .map(_apply)
        .map((_) => _state);
  }

  Iterable<MapEntry<K, V?>> _diffEntries(K key, V value) sync* {
    if (_reverseLookupTable.containsKey(value)) {
      yield MapEntry(_reverseLookupTable[value] as K, null);
    }
    yield MapEntry(key, value);
  }

  void _apply(MapEntry<K, V?> entry) {
    _state.putIfAbsent(entry.key, () => []);
    if (entry.value == null) {
      var value = _lookupTable[entry.key];
      if (value == null) throw StateError('Index is missing. ${entry.key}');
      _state[entry.key]!.remove(value);
      _lookupTable.remove(entry.key);
      _reverseLookupTable.remove(value);
    } else {
      _state[entry.key]!.add(entry.value as V);
      _lookupTable[entry.key] = entry.value as V;
      _reverseLookupTable[entry.value!] = entry.key;
    }
  }

  static GroupBy<int, V> fromList<V>(
      List<V> input, Stream<int> Function(V e) builder) {
    var instance = GroupBy(builder: builder);
    instance.addStream(Stream.fromIterable(input));
    return instance;
  }

  static Stream<GroupBy<int, V>> fromLists<V>(
          Stream<List<V>> inputs, Stream<int> Function(V e) builder) =>
      inputs.map((input) => fromList(input, builder));
}
