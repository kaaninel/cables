# Disposable Mixin

The `Disposable` mixin is used to manage the lifecycle of a stream. It ensures that resources are properly disposed of when they are no longer needed.

## Methods and Properties

### `initDisposable()`

Initializes the disposable mechanism. This method is called to set up the disposal process.

### `dispose()`

This method is called to dispose of the resources. It should be overridden by the class that uses the `Disposable` mixin to provide the actual disposal logic.

## Usage Example

Here is an example of how to use the `Disposable` mixin:

```dart
import 'package:kablo/kablo.dart';

class MyStream with Input<int>, Disposable<int> {
  MyStream() {
    initDisposable();
  }

  @override
  void dispose() {
    // Perform cleanup here
    print('Stream disposed');
  }
}

void main() {
  final myStream = MyStream();
  myStream.add(1);
  myStream.close();
}
```

In this example, the `MyStream` class uses the `Disposable` mixin to manage the lifecycle of the stream. When the stream is closed, the `dispose` method is called to perform any necessary cleanup.
