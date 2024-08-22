import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../main.dart';
import '../model/Team.dart';
import '../model/Tool.dart';
import '../view/EmergencyRequestView.dart';

// Backend for the "SearchTool" page.
class SearchToolViewModel {
  // Hashmap of markers to be displayed on the map for each team.
  static late Map<Team, Marker> _markers;
  // Map controller for moving the map's camera.
  static GoogleMapController? _mapController;

  // Loads in every team's location into the map, with none specifically selected.
  static void loadDefaultMarkers() {
    _markers = HashMap();
    getTeamMap().forEach((key, value) {
      _markers.addAll({
        value: Marker(
          markerId: MarkerId(key.toString()),
          position: value.getLocation(),
          infoWindow: InfoWindow(
              title: 'Team ' + key.toString() + ': ' + value.getName(),
              snippet: value.getBio()),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        )
      });
    });
  }

  // Returns the google map for display.
  static Widget getMap(BuildContext context) {
    return SizedBox(
      height: 570,
      child: GoogleMap(
        mapType: MapType.normal,
        //onTap: _onMapTapped,
        initialCameraPosition: const CameraPosition(
            target: LatLng(47.595878, -122.124834), zoom: 11),
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        markers: _markers.values.toSet(),
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }

  // Provides a list of all tool names present within the application.
  static List<String> getToolNames() {
    List<String> _results = [];
    getTeamMap().forEach((key, value) {
      for (Tool tool in value.getToolList()) {
        if (!_results.contains(tool.getTitle())) {
          _results.add(tool.getTitle().toLowerCase());
        }
      }
    });
    _results.sort();
    return _results;
  }

  // Recursive method for searching every team's tool list to find the desired tool.
  static void searchForTool(
      String _toolName,
      int _markerIndex,
      LatLng _closest,
      double _minDistance,
      bool _atLeastOneToolFound,
      State _state,
      BuildContext context) {
    // Base Case 1: All teams have been searched and the tool was found.
    if (_markerIndex == _markers.length && _atLeastOneToolFound) {
      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: _closest, zoom: 11)));
      _state.setState(() {});
      return;
    }
    // Base Case 2: All teams have been searched and the tool was not found.
    if (_markerIndex == _markers.length && !_atLeastOneToolFound) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Tool not found'),
              children: [
                Column(children: [
                  Text('"' +
                      _toolName +
                      '" does not belong to any team. Would you like to submit an emergency request?'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            SearchToolViewModel.routeToEmergencyRequest(
                                context);
                          },
                          child: const Text('Yes')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No')),
                    ],
                  ),
                ]),
              ],
            );
          });
      return;
    }
    // Recursive Case 1: There is stil another team's tool list to search.
    if (_markerIndex == 0) {
      loadDefaultMarkers();
    }
    // Iterates through each team's tool list to see if the tool name searched matches any.
    for (Tool tool in _markers.keys.elementAt(_markerIndex).getToolList()) {
      if (tool.getTitle() == _toolName) {
        _atLeastOneToolFound = true;
        // The team's google map marker is updated to reflect their possesion of the tool.
        updateMarker(_markers.keys.elementAt(_markerIndex), tool);
        // The distance between the logged in team and the team being searched is calculated using the pythagorean theorem.
        double _distanceToTool = sqrt(pow(
                (getLoggedInTeam()!.getLocation().latitude -
                        _markers.keys
                            .elementAt(_markerIndex)
                            .getLocation()
                            .latitude)
                    .abs(),
                2) +
            pow(
                (getLoggedInTeam()!.getLocation().longitude -
                        _markers.keys
                            .elementAt(_markerIndex)
                            .getLocation()
                            .longitude)
                    .abs(),
                2));
        // If this team is the closest instance of the tool existing, move the camera to this team.
        if (_distanceToTool < _minDistance) {
          _minDistance = _distanceToTool;
          _closest = _markers.keys.elementAt(_markerIndex).getLocation();
        }
        break;
      }
    }
    searchForTool(_toolName, _markerIndex + 1, _closest, _minDistance,
        _atLeastOneToolFound, _state, context);
  }

  // Changes the team's marker description from their biography to the availability of the searched tool.
  static void updateMarker(Team team, Tool tool) {
    String _snippet = 'x' +
        tool.getQuantity().toString() +
        ' ' +
        tool.getTitle() +
        ' avaliable on: ';
    if (tool.getDaysAvailable()[0]) {
      _snippet += 'Su ';
    }
    if (tool.getDaysAvailable()[1]) {
      _snippet += 'Mo ';
    }
    if (tool.getDaysAvailable()[2]) {
      _snippet += 'Tu ';
    }
    if (tool.getDaysAvailable()[3]) {
      _snippet += 'We ';
    }
    if (tool.getDaysAvailable()[4]) {
      _snippet += 'Th ';
    }
    if (tool.getDaysAvailable()[5]) {
      _snippet += 'Fr ';
    }
    if (tool.getDaysAvailable()[6]) {
      _snippet += 'Sa ';
    }
    Marker _marker = Marker(
        markerId: MarkerId((team.getNumber()).toString()),
        position: team.getLocation(),
        infoWindow: InfoWindow(
          title: 'Team ' + team.getNumber().toString() + ': ' + team.getName(),
          snippet: _snippet,
        ),
        icon: BitmapDescriptor.defaultMarker);
    _markers[team] = _marker;
  }

  // transitions to the emergency request page.
  static void routeToEmergencyRequest(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => const EmergencyRequestView())));
  }
}
