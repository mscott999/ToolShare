import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tool_share/main.dart';
import '../model/Team.dart';
import '../view/HomeView.dart';

// Backend for the "NewTeam" page.
class NewTeamViewModel {
  // Context of the newteam page for returning dialogs.
  static late BuildContext _bContext;
  // Temporary variables which are determined by the user's input on the page's widgets.
  static String _targetNumber = '';
  static String _targetPassword = '';
  static String _targetName = '';
  static String _targetDescription = '';

  static void init() {
    _targetNumber = '';
    _targetPassword = '';
    _targetName = '';
    _targetDescription = '';
  }

  // Returns a google map to display with each team's location present.
  static Widget getMap(BuildContext context) {
    _bContext = context;
    return Column(
      children: const [
        Text('Please select the team\'s location:',
            style: TextStyle(fontSize: 20)),
        SizedBox(
          height: 300,
          child: GoogleMap(
            mapType: MapType.normal,
            onTap: _onMapTapped,
            initialCameraPosition: CameraPosition(
                target: LatLng(47.595878, -122.124834), zoom: 11),
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
          ),
        )
      ],
    );
  }

  // method for the user to select the team's location by tapping on the map. Also serves as the submit button.
  static void _onMapTapped(LatLng location) {
    showDialog(
        context: _bContext,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Confirm Location?'),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Latitude: ' +
                      location.latitude.toStringAsFixed(6) +
                      '\nLongitude: ' +
                      location.longitude.toStringAsFixed(6)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            attemptNewUser(location);
                          },
                          child: const Text('Yes')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No')),
                    ],
                  )
                ],
              ),
            ],
          );
        });
  }

  // Methods runs several conditionals to see if a new team can be initialized.
  static void attemptNewUser(LatLng location) {
    Navigator.pop(_bContext);
    // Checks if a valid number was not given.
    if (int.tryParse(_targetNumber) == null || int.parse(_targetNumber) <= 0) {
      showDialog(
          context: _bContext,
          barrierDismissible: false,
          builder: (bContext) {
            return SimpleDialog(
              title: const Text('Invalid Number'),
              children: [
                Column(children: [
                  const Text('Please provide a valid team number.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bContext);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
      // Checks if the team number is already taken.
    } else if (getTeamMap().containsKey(int.parse(_targetNumber))) {
      showDialog(
          context: _bContext,
          barrierDismissible: false,
          builder: (bContext) {
            return SimpleDialog(
              title: const Text('Invalid Number'),
              children: [
                Column(children: [
                  const Text(
                      'Please provide a valid team number which has not yet been taken.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bContext);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
      // Checks if the password is at least four characters.
    } else if (_targetPassword.length < 4) {
      showDialog(
          context: _bContext,
          barrierDismissible: false,
          builder: (bContext) {
            return SimpleDialog(
              title: const Text('Invalid Password'),
              children: [
                Column(children: [
                  const Text(
                      'Please provide a password with at least four characters.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bContext);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
      // Checks if a team name has been given.
    } else if (_targetName.isEmpty) {
      showDialog(
          context: _bContext,
          barrierDismissible: false,
          builder: (bContext) {
            return SimpleDialog(
              title: const Text('Invalid Team Name'),
              children: [
                Column(children: [
                  const Text('Please provide the name of the robotics team.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bContext);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
      // Checks if a team description has been given.
    } else if (_targetDescription.isEmpty) {
      showDialog(
          context: _bContext,
          barrierDismissible: false,
          builder: (bContext) {
            return SimpleDialog(
              title: const Text('Invalid Team Description'),
              children: [
                Column(children: [
                  const Text(
                      'Please provide a short description for the robotics team.'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bContext);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
    } else {
      // Success scenario: new team is added to the applciation with empty tool and request lists.
      Team _newTeam = Team(int.parse(_targetNumber), location, [], [], [],
          _targetDescription, _targetName, _targetPassword);
      addTeamToMap(_newTeam);
      logInTeam(_newTeam);
      showDialog(
          context: _bContext,
          barrierDismissible: false,
          builder: (bContext) {
            return SimpleDialog(
              title: const Text('Team Successfully Initialized'),
              children: [
                Column(children: [
                  Text('Team ' +
                      _newTeam.getNumber().toString() +
                      ' has been added to the application!'),
                  ElevatedButton(
                      onPressed: () {
                        routeToHome(_bContext);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
    }
  }

  // setters used by the textfield for editing these private variables.
  static void setTargetNumber(String string) {
    _targetNumber = string;
  }

  static void setTargetPassword(String string) {
    _targetPassword = string;
  }

  static void setTargetName(String string) {
    _targetName = string;
  }

  static void setTargetDescription(String string) {
    _targetDescription = string;
  }

  // Method used for transitioning to the home screen.
  static void routeToHome(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const HomeView())));
  }
}
