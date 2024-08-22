import 'package:flutter/material.dart';
import 'package:tool_share/main.dart';
import 'package:tool_share/viewmodel/EmergencyReqeustViewModel.dart';

import '../model/Team.dart';

// Application page for viewing emergency requests. State is updated to reflect changes is a request is fulfilled.
class EmergencyRequestView extends StatefulWidget {
  const EmergencyRequestView({Key? key}) : super(key: key);

  @override
  _emergencyRequestViewState createState() => _emergencyRequestViewState();
}

class _emergencyRequestViewState extends State<EmergencyRequestView> {
  @override
  Widget build(BuildContext context) {
    bool _requestsExist = false;
    // Checks if there are any emergency requests.
    for (Team team in getTeamMap().values) {
      if (team.getEmergencyRequests().isNotEmpty) {
        _requestsExist = true;
        break;
      }
    }
    // If there are NO emergency requests, display error message.
    if (!_requestsExist) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Tool Share'),
        ),
        body: Column(children: [
          const Text('Emergency Requests', style: TextStyle(fontSize: 35)),
          const Text(
              'There are currently no tools being requested. Would you like to submit an emergency request?'),
          ElevatedButton(
            onPressed: () {
              EmergencyRequestViewModel.routeToNewEmergencyRequest(context);
            },
            child: const Text('New Emergency Request'),
          )
        ]),
      );
    }
    // If there ARE emergency requests, display them listed.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tool Share'),
      ),
      body: Column(children: [
        const Text('Emergency Requests', style: TextStyle(fontSize: 35)),
        EmergencyRequestViewModel.getRequests(context, this),
        ElevatedButton(
          onPressed: () {
            EmergencyRequestViewModel.routeToNewEmergencyRequest(context);
          },
          child: const Text('New Emergency Request'),
        )
      ]),
    );
  }
}
