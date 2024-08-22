import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tool_share/view/loginView.dart';
import 'model/Team.dart';

// HashMap of teams present within the application. The team's team number is used as the key for each value, allowing for instantaneous lookup.
HashMap<int, Team> _teamMap = HashMap();
// Non-volatile txt file containing each of the team's data recorded in JSON format.
late File _teamData;
// Team which is currently logged in and being altered.
Team? _loggedInTeam;

// Main function. Runs upon opening the application.
void main() {
  restoreData();
  runApp(const ToolShare());
}

// Material App wrapper which is always constant, even if the app's page changes.
class ToolShare extends StatelessWidget {
  const ToolShare({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tool Share',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const LoginView(),
    );
  }
}

// Method used to save every team's data to the txt file.
void saveData() {
  Map<String, dynamic> _tempMap = HashMap();
  for (int key in _teamMap.keys) {
    _tempMap.addAll({key.toString(): _teamMap[key]!.toJson()});
  }
  _teamData.writeAsStringSync(json.encode(_tempMap));
}

// Method used to restore the team hashmap using the nonvolatile data storage file.
void restoreData() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory _directory = await getApplicationDocumentsDirectory();
  _teamData = File('${_directory.path}/data.txt');
  // Catches exception if the txt file has not yet been made on this device.
  try {
    _teamData.readAsString();
  } on FileSystemException {
    _teamData.writeAsStringSync('');
  }
  // Catches exception if the txt file is empty.
  try {
    json.decode(_teamData.readAsStringSync());
  } on FormatException {
    _teamMap = HashMap();
    return;
  }
  Map<String, dynamic> _map = json.decode(_teamData.readAsStringSync());
  for (String string in _map.keys) {
    _teamMap.addAll({int.parse(string): Team.fromJson(_map[string])});
  }
}

// Sets the logged-in team identifier to the desired team.
void logInTeam(Team team) {
  _loggedInTeam = team;
}

// Logs out the current user, and their information cannot be altered once logged out.
void logOutTeam() {
  _loggedInTeam = null;
}

// Getter method for other file locations to access the logged-in team.
Team? getLoggedInTeam() {
  return _loggedInTeam;
}

// Adds a new team to the team hashmap.
void addTeamToMap(Team team) {
  _teamMap.addAll({team.getNumber(): team});
}

// Removes the indicated team from the team hashmap, effectively erasing them and their tools from the application.
void deleteTeam(Team? team) {
  _teamMap.remove(team!.getNumber());
}

// Returns the team hashmap.
HashMap getTeamMap() {
  return _teamMap;
}
