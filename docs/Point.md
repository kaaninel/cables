# Point Class

The `Point` class is a stream that holds a single value and emits new values when they are added. It is useful for managing state in a reactive way.

## Properties

- `T value`: The current value of the `Point`.

## Methods

- `Point(T value, {List<LogConfig<T>>? loggers})`: Constructor that initializes the `Point` with an initial value and optional loggers.
- `Pipe<T> whereNotNull()`: Returns a `Pipe` that emits non-null values.
- `Pipe<void> whereNull()`: Returns a `Pipe` that emits null values.
- `Stream<T> processor(Stream<T> input)`: Processes the input stream and emits new values when they are different from the current value.
- `void dispose()`: Disposes the `Point` and cancels the subscriptions.

## Usage Examples

```dart
import 'package:kablo/kablo.dart';

void main() {
  final point = Point<int>(0);

  point.listen((value) {
    print('Received: $value');
  });

  point.add(1);
  point.add(2);
  point.add(3);
}
```
