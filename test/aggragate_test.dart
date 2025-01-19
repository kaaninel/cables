import 'package:flutter_test/flutter_test.dart';
import 'package:kablo/kablo.dart';

void main() {
  group('Aggragate', () {
    late Aggragate<int, String> aggragate;

    setUp(() {
      aggragate = Aggragate<int, String>();
    });

    test('add method', () async {
      aggragate.add(const MapEntry(1, 'one'));
      expect(await aggragate.first, {1: 'one'});

      aggragate.add(const MapEntry(2, 'two'));
      expect(await aggragate.first, {1: 'one', 2: 'two'});

      aggragate.add(const MapEntry(1, null));
      expect(await aggragate.first, {2: 'two'});
    });

    test('asList method', () async {
      aggragate.add(const MapEntry(1, 'one'));
      aggragate.add(const MapEntry(2, 'two'));
      final lists = aggragate.asList().asPipe();
      expect(await lists.first, ['one']);
      expect(await lists.first, ['one', 'two']);
    });

    test('asSet method', () async {
      aggragate.add(const MapEntry(1, 'one'));
      aggragate.add(const MapEntry(2, 'two'));

      final set = aggragate.asSet().asPipe();
      expect(await set.first, {'one'});
      expect(await set.first, {'one', 'two'});
    });
  });
}
