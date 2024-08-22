import 'package:flutter/material.dart';
import 'package:tool_share/main.dart';
import '../viewmodel/HomeViewModel.dart';

// Home page of the application.
class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Displays a notification if this team has had their request fulfilled.
    HomeViewModel.loadFulfilledRequests(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tool Share'),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  // "Add tool" button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 100),
                    ),
                    onPressed: () {
                      HomeViewModel.routeToAddTool(context);
                    },
                    child: const Text(
                      'Add New Tool To Team',
                      textScaleFactor: 1.4,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  // "Delete tool" button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 100),
                    ),
                    onPressed: () {
                      HomeViewModel.routeToDeleteTool(context);
                    },
                    child: const Text('Remove Tool From Team',
                        textScaleFactor: 1.4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 8.0,
                    right: 8.0,
                  ),
                  // "Search for tool" button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 100),
                    ),
                    onPressed: () {
                      HomeViewModel.routeToSearchTool(context);
                    },
                    child: const Text('Search For Tool', textScaleFactor: 1.4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15.0, left: 8.0, right: 8.0, bottom: 15.0),
                  // "Emergency requests" button
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 100),
                    ),
                    onPressed: () {
                      HomeViewModel.routeToEmergencyRequest(context);
                    },
                    child:
                        const Text('Emergency Requests', textScaleFactor: 1.4),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Sign out, return to login button
                    ElevatedButton(
                      onPressed: () {
                        HomeViewModel.logOut(context);
                        saveData();
                      },
                      child: const Text("Sign Out"),
                    ),
                    // Delete team, return to login button.
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red, onPrimary: Colors.yellow),
                      onPressed: () {
                        HomeViewModel.delete(context);
                        saveData();
                      },
                      child: const Text("Delete Team"),
                    ),
                  ],
                )
              ]),
        ));
  }
}
