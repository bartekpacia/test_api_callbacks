import 'package:test/test.dart';

import 'boilerplate.dart';
import 'global_state.dart' as global_state;

void main() {
  global_state.requestedTest = 'B testA';
  print('Requested test "${global_state.requestedTest}"');

  patrolTest('xd', testBody);

  group('testA', () {
    patrolSetUpAll(setUpAllBody);
    patrolSetUpAll(setUpAllBody);

    patrolTest('testA', testBody);
  });

  group('B', () {
    patrolSetUpAll(setUpAllBody);
    patrolSetUpAll(setUpAllBody);

    patrolTest('testA', testBody);
  });
}
