# Aggragate Class

The `Aggragate` class is a stream that aggregates key-value pairs into a map. It allows you to add, remove, and clear entries in the map, and provides methods to convert the map to a list or set.

## Purpose

The `Aggragate` class is used to collect and manage key-value pairs in a map. It is useful for scenarios where you need to aggregate data from multiple sources and maintain a consistent state.

## Methods and Properties

### Properties

- `Map<K, V> value`: The current state of the aggregated map.

### Methods

- `void add(MapEntry<K, V?> entry)`: Adds a key-value pair to the map. If the value is `null`, the key is removed from the map.
- `Stream<List<V>> asList()`: Returns a stream of the map's values as a list.
- `Stream<Set<V>> asSet()`: Returns a stream of the map's values as a set.
- `void clear()`: Clears the map.
- `static Aggragate<int, V> fromStreams<V>(List<Stream<V>> streams)`: Creates an `Aggragate` instance from a list of streams.

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

void main() {
  final aggragate = Aggragate<String, int>();

  aggragate.listen((map) {
    print('Current map: $map');
  });

  aggragate.add(MapEntry('a', 1));
  aggragate.add(MapEntry('b', 2));
  aggragate.add(MapEntry('a', null)); // Removes the key 'a'
}
```

### Example 2: Aggregating Streams

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream.fromIterable([1, 2, 3]);
  final stream2 = Stream.fromIterable([4, 5, 6]);

  final aggragate = Aggragate<int, int>.fromStreams([stream1, stream2]);

  aggragate.listen((map) {
    print('Current map: $map');
  });
}
```
