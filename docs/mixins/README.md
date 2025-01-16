# Mixins

This section provides an overview of the mixins available in the Kablo library. Mixins are used to add functionality to classes without using inheritance. They allow you to combine multiple behaviors into a single class.

## Available Mixins

### [Disposable](Disposable.md)

The `Disposable` mixin is used to manage the lifecycle of a stream. It ensures that resources are properly disposed of when they are no longer needed.

### [Input](Input.md)

The `Input` mixin is used to define the input stream for a class. It provides a `StreamSink` interface for adding events to the input stream.

### [InputCounter](InputCounter.md)

The `InputCounter` mixin is used to count the number of input events in a stream. It provides a way to keep track of how many times an input event has been added to the input stream.

### [InputLogger](InputLogger.md)

The `InputLogger` mixin is used to log input events in a stream. It provides a way to attach logging configurations to the input stream of a class that implements the `Input` mixin.

### [Lag](Lag.md)

The `Lag` mixin is used to calculate the lag between the input and output counts in a stream. It extends the functionality of `InputCounter`, `OutputCounter`, and `Passthrough` mixins.

### [LogConfig](LogConfig.md)

The `LogConfig` class is an abstract class that defines the configuration for logging events in a stream. It provides a way to specify the name and log level for the logging configuration and requires the implementation of the `onLog` method to handle the logging of events.

### [Output](Output.md)

The `Output` mixin is used to provide an output stream for a class. It allows other classes to listen to the output stream and receive events.

## Note

This documentation is AI-generated and may contain inaccuracies. Please refer to the source code and official documentation for the most accurate and up-to-date information.
