import 'package:flutter/material.dart';
import '../main.dart';
import '../model/EmergencyRequest.dart';
import '../view/AddToolView.dart';
import '../view/DeleteToolView.dart';
import '../view/EmergencyRequestView.dart';
import '../view/LoginView.dart';
import '../view/SearchToolView.dart';

// Backend for the home page of the applicaton.
class HomeViewModel {
  // Method for logging out the current user and transitioning to the log in page.
  static void logOut(BuildContext context) {
    logOutTeam();
    routeToLogin(context);
  }

  // Method for displaying "request fulfilled!" notifications upon page boot.
  static Future<void> loadFulfilledRequests(BuildContext context) async {
    // waits for page to load before showing notifications.
    await Future.delayed(Duration.zero);
    for (EmergencyRequest request
        in getLoggedInTeam()!.getFulfilledRequests()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return SimpleDialog(
              title: const Text('Emergency Request Fulfilled!'),
              children: [
                Column(children: [
                  Text('Your team\'s request for "' +
                      request.getName() +
                      '" has been fulfilled!'),
                  ElevatedButton(
                      onPressed: () {
                        getLoggedInTeam()!
                            .getFulfilledRequests()
                            .remove(request);
                        Navigator.pop(context);
                      },
                      child: const Text('Ok')),
                ]),
              ],
            );
          });
    }
  }

  // Method for making the user confirm that they wish to delete their team.
  static void delete(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Delete Team?'),
            children: [
              Column(children: [
                const Text('This is an irreversible action. Proceed?'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.red, onPrimary: Colors.yellow),
                        onPressed: () {
                          Navigator.pop(context);
                          deleteTeam(getLoggedInTeam());
                          logOut(context);
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
  }

  // Methods for routing between the application's different pages.
  static void routeToAddTool(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const AddToolView())));
  }

  static void routeToDeleteTool(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const DeleteToolView())));
  }

  static void routeToSearchTool(context) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: ((context) => const SearchToolView())));
  }

  static void routeToEmergencyRequest(context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: ((context) => const EmergencyRequestView())));
  }

  static void routeToLogin(context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const LoginView())));
  }
}
