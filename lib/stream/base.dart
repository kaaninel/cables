part of '../kablo.dart';

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

mixin Passthrough<T> on Input<T>, Output<T> {
  StreamSubscription<T> initPassthrough() =>
      inputStream.stream.listen(outputStream.add);
}

mixin Processor<T, Q> on Input<T>, Output<Q> {
  StreamSubscription<Q> initProcessor() => inputStream.stream
      .transform(StreamTransformer.fromBind(processor))
      .listen(outputStream.add);

  Stream<Q> processor(Stream<T> input);
}

mixin Listener<T> on Input<T> {
  void initListener() => listener(inputStream.stream);
  void listener(Stream<T> input);
}
