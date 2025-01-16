# AggregateExtension Extension

The `AggregateExtension` extension provides a convenient way to convert a stream of `MapEntry` objects into an `Aggragate` instance. This extension simplifies the process of aggregating key-value pairs into a map.

## Purpose

The `AggregateExtension` extension is used to extend the functionality of streams, allowing them to be easily converted into `Aggragate` instances. This is useful for scenarios where you need to aggregate data from multiple sources and maintain a consistent state.

## Methods and Properties

### Methods

- `Aggragate<K, V> asAggragate()`: Converts the stream of `MapEntry` objects into an `Aggragate` instance.

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream = Stream.fromIterable([
    MapEntry('a', 1),
    MapEntry('b', 2),
    MapEntry('a', null), // Removes the key 'a'
  ]);

  final aggragate = stream.asAggragate();

  aggragate.listen((map) {
    print('Current map: $map');
  });
}
```

### Example 2: Aggregating Streams

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream.fromIterable([MapEntry('a', 1), MapEntry('b', 2)]);
  final stream2 = Stream.fromIterable([MapEntry('c', 3), MapEntry('d', 4)]);

  final aggragate = StreamGroup.merge([stream1, stream2]).asAggragate();

  aggragate.listen((map) {
    print('Current map: $map');
  });
}
```
