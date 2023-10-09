import 'package:test/test.dart';

import 'boilerplate.dart';
import 'global_state.dart' as global_state;
// Question: Can setUpAlls() in sibling groups run after tests in another group?
// Answer: yes.

// Problem: All tests are *always executed*. Yes, they're skipped, but they're
// still executed. This means their setUpAll callbacks run.
// Question: How to know whether to skip execution of a setUpAll callbacks?

// Idea
//
// If, inside setUpAll calllback, the requestedTestName contains the whole
// parentGroupName, then execute the callbacks. Otherwise skip it.

void main() {
  print('Requested test ${global_state.requestedTest}');

  group('A', () {
    patrolSetUpAll(setUpAllBody);
    patrolSetUpAll(setUpAllBody);

    patrolTest('testA', testBody);
    patrolTest('testB', testBody);
    patrolTest('testC', testBody);
  });

  group('B', () {
    // Question: do the 2 setUpAlls below run before tests in group A?
    // Answer: no, of course not.

    patrolSetUpAll(setUpAllBody);
    patrolSetUpAll(setUpAllBody);

    patrolTest('testA', testBody);
    patrolTest('testB', testBody);
    patrolTest('testC', testBody);
  });
}
