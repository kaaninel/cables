import 'package:flutter_test/flutter_test.dart';
import 'package:kablo/kablo.dart';

void main() {
  group('Pipe', () {
    test('add method', () {
      final pipe = Pipe<int>();
      pipe.add(1);
      pipe.add(2);
      pipe.add(3);

      expect(pipe.inputCount, 3);
    });

    test('listen method', () async {
      final pipe = Pipe<int>();
      final values = <int>[];

      pipe.listen((value) {
        values.add(value);
      });

      pipe.add(1);
      pipe.add(2);
      pipe.add(3);

      await Future.delayed(Duration(milliseconds: 100));

      expect(values, [1, 2, 3]);
    });
  });
}
