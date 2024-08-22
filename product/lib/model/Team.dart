import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tool_share/model/EmergencyRequest.dart';
import 'Tool.dart';

class Team {
  // Integer value representing the number given to every robotics team by FRC themselves.
  final int _number;
  // Latitude-Longitude coordinates of the team's operating location.
  final LatLng _location;
  // List of tools owned by the team that they are willing to share.
  late List<Tool> _toolList;
  // List of requests for tools that the team needs yet is not owned by other teams.
  late List<EmergencyRequest> _emergencyRequests;
  // List of requests which have been fulfilled by other teams.
  late List<EmergencyRequest> _fulfilledRequests;
  // Short description used by the team to express themselves to other teams.
  final String _bio;
  // The name of the team itself.
  final String _name;
  // Unique password used by the team to identify themselves.
  final String _password;

  // Constructor for initializing a new team into the applciation
  Team(this._number, this._location, this._toolList, this._emergencyRequests,
      this._fulfilledRequests, this._bio, this._name, this._password);

  // Constructor used to initialize a new team from a JSON text format.
  Team.fromJson(Map<String, dynamic> json)
      : _number = int.parse(json['_number']),
        _location = LatLng(
            double.parse(json['_latitude']), double.parse(json['_longitude'])),
        _toolList =
            json['_toolList'].map<Tool>((i) => Tool.fromJson(i)).toList(),
        _emergencyRequests = json['_emergencyReqeusts']
            .map<EmergencyRequest>((i) => EmergencyRequest.fromJson(i))
            .toList(),
        _fulfilledRequests = json['_fulfilledRequests']
            .map<EmergencyRequest>((i) => EmergencyRequest.fromJson(i))
            .toList(),
        _bio = json['_bio'],
        _name = json['_name'],
        _password = json['_password'];

  // Converts a preexisting Team instance to a JSON text format.
  Map<String, dynamic> toJson() {
    List<Map> _toolList = this._toolList.map((i) => i.toJson()).toList();
    List<Map> _emergencyRequests =
        this._emergencyRequests.map((i) => i.toJson()).toList();
    List<Map> _fulfilledRequests =
        this._fulfilledRequests.map((i) => i.toJson()).toList();
    return {
      '_number': _number.toString(),
      '_latitude': _location.latitude.toString(),
      '_longitude': _location.longitude.toString(),
      '_toolList': _toolList,
      '_emergencyReqeusts': _emergencyRequests,
      '_fulfilledRequests': _fulfilledRequests,
      '_bio': _bio,
      '_name': _name,
      '_password': _password,
    };
  }

  // Adds a new Tool isntance to the Team.
  void addTool(Tool tool) {
    _toolList.add(tool);
  }

  // Removes a tool from the team.
  void removeTool(Tool tool) {
    _toolList.remove(tool);
  }

  // Generic compareTo method to display team numbers in a numeric order.
  int compareTo(Team team) {
    return _number.compareTo(team.getNumber());
  }

  // Getter method for accessing the private number variable.
  int getNumber() {
    return _number;
  }

  // Getter method for accessing the private location variable.
  LatLng getLocation() {
    return _location;
  }

  // Getter method for accessing the private toolList variable.
  List<Tool> getToolList() {
    return _toolList;
  }

  // Getter method for accessing the private emergencyRequestList variable.
  List<EmergencyRequest> getEmergencyRequests() {
    return _emergencyRequests;
  }

  // Getter method for accessing the private fulfilledRequestsList variable.
  List<EmergencyRequest> getFulfilledRequests() {
    return _fulfilledRequests;
  }

  // Removes a specified request from the fulfilledRequests list.
  void removeFulfilledRequest(EmergencyRequest request) {
    _fulfilledRequests.remove(request);
  }

  // Removes a specified request from the emergencyRequest List.
  void removeRequest(EmergencyRequest emergencyRequest) {
    _emergencyRequests.remove(emergencyRequest);
  }

  // Returns the team's short description.
  String getBio() {
    return _bio;
  }

  // Getter method for the team's private name variable.
  String getName() {
    return _name;
  }

  // Getter method for the team's private password variable.
  String getPassword() {
    return _password;
  }
}
