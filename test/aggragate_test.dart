import 'package:flutter_test/flutter_test.dart';
import 'package:kablo/kablo.dart';

void main() {
  group('Aggragate', () {
    late Aggragate<int, String> aggragate;

    setUp(() {
      aggragate = Aggragate<int, String>();
    });

    test('add method', () {
      aggragate.add(MapEntry(1, 'one'));
      expect(aggragate.value, {1: 'one'});

      aggragate.add(MapEntry(2, 'two'));
      expect(aggragate.value, {1: 'one', 2: 'two'});

      aggragate.add(MapEntry(1, null));
      expect(aggragate.value, {2: 'two'});
    });

    test('asList method', () async {
      aggragate.add(MapEntry(1, 'one'));
      aggragate.add(MapEntry(2, 'two'));

      final list = await aggragate.asList().first;
      expect(list, ['one', 'two']);
    });

    test('asSet method', () async {
      aggragate.add(MapEntry(1, 'one'));
      aggragate.add(MapEntry(2, 'two'));

      final set = await aggragate.asSet().first;
      expect(set, {'one', 'two'});
    });
  });
}
