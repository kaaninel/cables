part of '../kablo.dart';

mixin Input<T> implements StreamSink<T> {
  final StreamController<T> _input = StreamController.broadcast();

  @override
  void add(T event) => _input.add(event);

  @override
  void addError(Object error, [StackTrace? stackTrace]) =>
      _input.addError(error, stackTrace);

  @override
  Future<void> addStream(Stream<T> stream) => stream.forEach(add);

  @override
  Future<void> close() => _input.close();

  @override
  Future<void> get done => _input.done;
}

mixin Output<T> on Stream<T> {
  final StreamController<T> _output = StreamController.broadcast();

  @override
  StreamSubscription<T> listen(
    void Function(T event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) =>
      _output.stream.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

mixin Passthrough<T> on Input<T>, Output<T> {
  StreamSubscription<T> initPassthrough() => _input.stream.listen(_output.add);
}

mixin Processor<T, Q> on Input<T>, Output<Q> {
  StreamSubscription<Q> initProcessor() => _input.stream
      .transform(StreamTransformer.fromBind(processor))
      .listen(_output.add);

  Stream<Q> processor(Stream<T> input);
}
