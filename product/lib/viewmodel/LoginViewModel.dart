import 'package:flutter/material.dart';
import 'package:tool_share/main.dart';
import 'package:tool_share/view/HomeView.dart';
import '../view/NewTeamView.dart';

// Backend for the login page.
class LoginViewModel {
  // Temporary variables which are altered upon interaction with the text fields.
  static String _targetNumber = '';
  static String _targetPassword = '';

  static void init() {
    _targetNumber = '';
    _targetPassword = '';
  }

  // Method for running several conditionals to see if all criterion were met for initializing a new team.
  static void attemptLogin(BuildContext context) {
    // Displays error dialog if the user has not typed in a valid number.
    if (_targetNumber.isEmpty || int.tryParse(_targetNumber) == null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Invalid Number'),
              children: [
                Column(children: [
                  const Text('Please provide a team number.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
      // Displays error dialog if the user has not typed in a valid password.
    } else if (_targetPassword.isEmpty) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Invalid Password'),
              children: [
                Column(children: [
                  const Text('Please provide a team password.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
      // Displays error dialog if the team does not exist.
    } else if (!getTeamMap().containsKey(int.parse(_targetNumber)) ||
        getTeamMap()[int.parse(_targetNumber)].getPassword() !=
            _targetPassword) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Invalid Credentials'),
              children: [
                Column(children: [
                  const Text(
                      'The given team number and password do not match any team.'),
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
      // Successfully logs in user.
      logInTeam(getTeamMap()[int.parse(_targetNumber)]);
      routeToHome(context);
    }
  }

  // Methods for routing to different pages.
  static void routeToNewUser(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const NewTeamView())));
  }

  static void routeToHome(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const HomeView())));
  }

  // Methods used by the text fields to edit these private variables.
  static void setTargetNumber(String string) {
    _targetNumber = string;
  }

  static void setTargetPassword(String string) {
    _targetPassword = string;
  }
}
