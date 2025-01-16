# Processor Mixin

The `Processor` mixin is used to process input streams and produce output streams. It provides a mechanism to transform input data into output data using a custom processor function.

## Methods and Properties

### `initProcessor()`

Initializes the processor by creating a duplex subscription for the input and output streams.

### `disposeProcessor()`

Disposes the processor by canceling the input and output subscriptions.

### `processor(Stream<T> input)`

Abstract method that defines the processing logic for transforming input data into output data. This method must be implemented by the class that uses the `Processor` mixin.

## Usage Examples

Here is an example of how to use the `Processor` mixin in a custom class:

```dart
import 'package:kablo/kablo.dart';

class CustomProcessor extends Stream<int> with Input<int>, Output<int>, Processor<int, int> {
  @override
  Stream<int> processor(Stream<int> input) async* {
    await for (final value in input) {
      yield value * 2; // Example processing logic: multiply input by 2
    }
  }

  CustomProcessor() {
    initProcessor();
  }

  void dispose() {
    disposeProcessor();
  }
}

void main() {
  final processor = CustomProcessor();

  processor.listen((value) {
    print('Processed value: $value');
  });

  processor.add(1);
  processor.add(2);
  processor.add(3);
}
```
