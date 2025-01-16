# AggregateListExtension Extension

The `AggregateListExtension` extension provides a convenient way to convert a list of streams into an `Aggragate` instance. This extension simplifies the process of aggregating data from multiple streams into a single map.

## Purpose

The `AggregateListExtension` extension is used to extend the functionality of lists of streams, allowing them to be easily converted into `Aggragate` instances. This is useful for scenarios where you need to aggregate data from multiple sources and maintain a consistent state.

## Methods and Properties

### Methods

- `Aggragate<int, V> asAggragate()`: Converts the list of streams into an `Aggragate` instance.

## Usage Examples

### Example 1: Basic Usage

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream.fromIterable([1, 2, 3]);
  final stream2 = Stream.fromIterable([4, 5, 6]);

  final aggragate = [stream1, stream2].asAggragate();

  aggragate.listen((map) {
    print('Current map: $map');
  });
}
```

### Example 2: Aggregating Multiple Streams

```dart
import 'package:kablo/kablo.dart';

void main() {
  final stream1 = Stream.fromIterable([1, 2, 3]);
  final stream2 = Stream.fromIterable([4, 5, 6]);
  final stream3 = Stream.fromIterable([7, 8, 9]);

  final aggragate = [stream1, stream2, stream3].asAggragate();

  aggragate.listen((map) {
    print('Current map: $map');
  });
}
```
