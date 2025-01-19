import 'package:flutter_test/flutter_test.dart';
import 'package:kablo/kablo.dart';

class TestController extends Controller<int, String> {
  TestController(String value) : super(value);

  @override
  Stream<String> onTask(int task) async* {
    yield 'Task $task';
  }
}

void main() {
  group('Controller', () {
    test('initialization', () {
      final controller = TestController('Initial');
      expect(controller.value, 'Initial');
    });

    test('dispose', () {
      final controller = TestController('Initial');
      controller.dispose();
      expect(controller.inputStream.isClosed, true);
    });

    test('onTask', () async {
      final controller = TestController('Initial');
      controller.add(1);
      await expectLater(controller, emitsInOrder(['Task 1']));
    });
  });
}
