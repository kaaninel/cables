part of '../kablo.dart';

/// The `Input` mixin provides a `StreamSink` interface for adding events to the input stream.
mixin Input<T> implements StreamSink<T> {
  final StreamController<T> inputStream = StreamController.broadcast();

  @override
  void add(T event) => inputStream.add(event);

  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      inputStream.addError(error, stackTrace);

  @override
  Future<void> addStream(Stream<T> stream) => stream.forEach(add);

  @override
  Future<void> close() => inputStream.close();

  @override
  Future<void> get done => inputStream.done;
}

/// The `Output` mixin provides an output stream for a class, allowing other classes to listen to the output stream and receive events.
mixin Output<T> on Stream<T> {
  final StreamController<T> outputStream = StreamController.broadcast();

  @override
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      outputStream.stream.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

/// The `Passthrough` mixin connects the input stream to the output stream, allowing events to pass through from input to output.
mixin Passthrough<T> on Input<T>, Output<T> {
  late final StreamSubscription<T> _passthroughSubscription;
  StreamSubscription<T> initPassthrough() {
    _passthroughSubscription = inputStream.stream.listen(outputStream.add);
    return _passthroughSubscription;
  }

  void disposePassthrough() {
    _passthroughSubscription.cancel();
  }
}

/// The `Disposable` mixin provides a mechanism to dispose of resources when they are no longer needed.
mixin Disposable<T> on Input<T> {
  void initDisposable() => inputStream.done.then((value) => dispose());

  void dispose();
}

/// The `DuplexSubscription` class represents a pair of stream subscriptions for input and output streams.
class DuplexSubscription<T, Q> {
  final StreamSubscription<T> inputSub;
  final StreamSubscription<Q> outputSub;

  const DuplexSubscription(this.inputSub, this.outputSub);
}

/// The `Processor` mixin provides a mechanism to process input streams and yield output streams.
mixin Processor<T, Q> on Input<T>, Disposable<T>, Output<Q> {
  late final DuplexSubscription<T, Q> _processorSubscription;
  DuplexSubscription<T, Q> initProcessor() {
    final controller = StreamController<T>();
    final inputSub = inputStream.stream.listen(controller.add,
        onDone: controller.close, onError: controller.addError);
    final outputSub = controller.stream
        .transform(StreamTransformer.fromBind(processor))
        .listen(outputStream.add);
    _processorSubscription = DuplexSubscription(inputSub, outputSub);
    return _processorSubscription;
  }

  void disposeProcessor() {
    _processorSubscription.inputSub.cancel();
    _processorSubscription.outputSub.cancel();
  }

  Stream<Q> processor(Stream<T> input);
}
