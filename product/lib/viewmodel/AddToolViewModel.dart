import 'package:flutter/material.dart';
import 'package:tool_share/main.dart';
import '../model/Tool.dart';
import '../view/HomeView.dart';

// Back end of the "AddToolView" page.
class AddToolViewModel {
  // Temporary variables which are altered as the user interacts with the textfields, quantity picker, and day selectors. Default values are provided.
  static int _targetQuantity = 2;
  static String _targetName = '';
  static bool _targetSunday = false;
  static bool _targetMonday = false;
  static bool _targetTuesday = false;
  static bool _targetWednesday = false;
  static bool _targetThursday = false;
  static bool _targetFriday = false;
  static bool _targetSaturday = false;

  // Method used to first check if the team already has this tool, and if not, add it to the team.
  static void attemptAdd(BuildContext context) {
    // Checks if tool aready exists, throws error dialog.
    bool _alreadyExists = false;
    getLoggedInTeam()!.getToolList().forEach((Tool tool) {
      if (_targetName == tool.getTitle()) {
        _alreadyExists = true;
      }
    });
    // Checks if a tool name was given. If not, throws error dialog.
    if (_targetName.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              title: const Text('No Tool Name Provided'),
              children: [
                Column(children: [
                  const Text('Please provide the equipment\'s name or title.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
      // Checks if the tool is available at least one day of the week. If not, throw error dialog.
    } else if (!_targetSunday &&
        !_targetMonday &&
        !_targetTuesday &&
        !_targetWednesday &&
        !_targetThursday &&
        !_targetFriday &&
        !_targetSaturday) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Tool Always unavailable'),
              children: [
                Column(children: [
                  const Text(
                      'Equipment must be avaliable for at least one day of the week'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
    } else if (_alreadyExists) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            // Dialog box where user can choose to override preexisting tool.
            return SimpleDialog(
              title: const Text('Equipment Already Added'),
              children: [
                Column(children: [
                  Text(_targetName +
                      ' has already been added to this team. Do you wish to overwrite?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // Add tool to team.
                            getLoggedInTeam()!.getToolList().removeWhere(
                                (tool) => tool.getTitle() == _targetName);
                            Navigator.pop(context);
                            getLoggedInTeam()!.addTool(Tool(
                                _targetQuantity,
                                [
                                  _targetSunday,
                                  _targetMonday,
                                  _targetTuesday,
                                  _targetWednesday,
                                  _targetThursday,
                                  _targetFriday,
                                  _targetSaturday
                                ],
                                _targetName));
                            // Success message.
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return SimpleDialog(
                                    title: const Text(
                                        'Equipment Successfully Added'),
                                    children: [
                                      Column(children: [
                                        Text('"' +
                                            _targetName +
                                            '" has been added to your team!'),
                                        ElevatedButton(
                                            onPressed: () {
                                              routeToHome(context);
                                            },
                                            child: const Text('Ok')),
                                      ]),
                                    ],
                                  );
                                });
                          },
                          child: const Text('Yes')),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('No'),
                      ),
                    ],
                  ),
                ]),
              ],
            );
          });
    } else {
      // Adds tool to team if not yet done so.
      getLoggedInTeam()!.addTool(Tool(
          _targetQuantity,
          [
            _targetSunday,
            _targetMonday,
            _targetTuesday,
            _targetWednesday,
            _targetThursday,
            _targetFriday,
            _targetSaturday
          ],
          _targetName));
      // Success message.
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Equipment Successfully Added'),
              children: [
                Column(children: [
                  Text('"' + _targetName + '" has been added to your team!'),
                  ElevatedButton(
                      onPressed: () {
                        routeToHome(context);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
    }
  }

  // Transitions to home screen.
  static void routeToHome(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const HomeView())));
  }

  // Updates private variable per user input.
  static void setTargetQuantity(int value) {
    _targetQuantity = value;
  }

  // Rturns the quantity number to display.
  static int getTargetQuantity() {
    return _targetQuantity;
  }

  // Updates private variables per user input.
  static void setTargetName(String string) {
    _targetName = string;
  }

  static void setTargetSunday(bool value) {
    _targetSunday = value;
  }

  static bool getTargetSunday() {
    return _targetSunday;
  }

  static void setTargetMonday(bool value) {
    _targetMonday = value;
  }

  static bool getTargetMonday() {
    return _targetMonday;
  }

  static void setTargetTuesday(bool value) {
    _targetTuesday = value;
  }

  static bool getTargetTuesday() {
    return _targetTuesday;
  }

  static void setTargetWednesday(bool value) {
    _targetWednesday = value;
  }

  static bool getTargetWednesday() {
    return _targetWednesday;
  }

  static void setTargetThursday(bool value) {
    _targetThursday = value;
  }

  static bool getTargetThursday() {
    return _targetThursday;
  }

  static void setTargetFriday(bool value) {
    _targetFriday = value;
  }

  static bool getTargetFriday() {
    return _targetFriday;
  }

  static void setTargetSaturday(bool value) {
    _targetSaturday = value;
  }

  static bool getTargetSaturday() {
    return _targetSaturday;
  }
}
