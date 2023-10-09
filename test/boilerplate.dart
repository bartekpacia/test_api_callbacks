import 'package:test/test.dart';
// ignore: depend_on_referenced_packages
import 'package:test_api/src/backend/invoker.dart';

import 'global_state.dart' as global_state;

/// A modification of [setUpAll] that works with Patrol's native automation.
///
/// It keeps track of calls made to setUpAll.
void patrolSetUpAll(Future<void> Function() body) {
  setUpAll(() async {
    final parentGroupsName = Invoker.current!.liveTest.groups.last.name;

    final name = addSetUpAll(parentGroupsName);

    // Skip calling body if is in test discovery phase

    // Skip calling body if it was already executed

    // Skip calling if parentGroupName is not a substring of requestedTestName

    body();

    // Mark this setUpAll as executed
  });
}

void patrolTest(String name, Future<void> Function() body) {
  test(name, () async {
    final currentTest = global_state.currentTestFullName;

    if (currentTest == global_state.requestedTest) {
      print('Requested test $currentTest, will execute it');
      await body();
    }
  });
}

/// Adds a setUpAll callback to the list of all setUpAll callbacks.
///
/// Returns the name under which this setUpAll callback was added.
String addSetUpAll(String group) {
  // Not optimal, but good enough for now.

  // Go over all groups, checking if the group is already in the list.
  var groupIndex = 0;
  for (final setUpAll in global_state.setUpAlls) {
    final parts = setUpAll.split(' ');
    final groupName = parts.sublist(0, parts.length - 1).join(' ');

    if (groupName == group) {
      groupIndex++;
    }
  }

  final name = '$group $groupIndex';

  global_state.setUpAlls.add(name);
  return name;
}

void printSetUpAlls() {
  print('setUpAlls:');
  for (final setUpAll in global_state.setUpAlls) {
    print('  $setUpAll');
  }
}

Future<void> testBody() async {
  print(global_state.currentTestFullName);
}

Future<void> setUpAllBody() async {
  print('setUpAll in group ${global_state.currentTestFullName}');
}
