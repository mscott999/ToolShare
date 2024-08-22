import 'package:flutter/material.dart';
import 'package:tool_share/main.dart';
import 'package:tool_share/model/EmergencyRequest.dart';
import '../view/EmergencyRequestView.dart';

// Backend for the "NewEmergencyRequest" page.
class NewEmergencyRequestViewModel {
  // Temporary variables which are determined by the user's input on the page.
  static int _targetQuantity = 2;
  static String _targetName = '';

  // Method for running several conditionals to see if all criterion have been met for adding a new request.
  static void attemptNewRequest(BuildContext context) {
    // Throws an error dialog if a tool name has not been given.
    if (_targetName.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Invalid Request'),
              children: [
                Column(children: [
                  const Text('No name has been given for the request tool.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
    } else {
      // Successfully adds request.
      getLoggedInTeam()!
          .getEmergencyRequests()
          .add(EmergencyRequest(_targetName, _targetQuantity));
      routeToEmergencyRequest(context);
    }
  }

  static void setTargetQuantity(int value) {
    _targetQuantity = value;
  }

  static int getTargetQuantity() {
    return _targetQuantity;
  }

  static void setTargetName(String string) {
    _targetName = string;
  }

  static void routeToEmergencyRequest(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => const EmergencyRequestView())));
  }
}
