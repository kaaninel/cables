# Passthrough Mixin

## Purpose

The `Passthrough` mixin is used to create a simple passthrough mechanism for streams. It allows the input stream to be directly passed to the output stream without any modifications.

## Methods and Properties

### `initPassthrough()`

Initializes the passthrough mechanism by creating a subscription that listens to the input stream and adds events to the output stream.

### `disposePassthrough()`

Disposes the passthrough mechanism by canceling the subscription created in `initPassthrough()`.

## Usage Examples

Here is an example of how to use the `Passthrough` mixin:

```dart
import 'package:kablo/kablo.dart';

class MyPassthrough extends Stream<int> with Input<int>, Output<int>, Passthrough<int> {
  MyPassthrough() {
    initPassthrough();
  }

  @override
  StreamSubscription<int> listen(void Function(int event)? onData, {Function? onError, void Function()? onDone, bool? cancelOnError}) {
    return outputStream.stream.listen(onData, onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  }
}

void main() {
  final passthrough = MyPassthrough();

  passthrough.listen((value) {
    print('Received: $value');
  });

  passthrough.add(1);
  passthrough.add(2);
  passthrough.add(3);
}
```
