import 'package:flutter/material.dart';
import 'package:tool_share/main.dart';

import '../viewmodel/DeleteToolViewModel.dart';

//Application page for removing tools from an account. The state is updated to reflect changes in the team's tool list.
class DeleteToolView extends StatefulWidget {
  const DeleteToolView({Key? key}) : super(key: key);

  @override
  _DeleteToolViewState createState() => _DeleteToolViewState();
}

class _DeleteToolViewState extends State<DeleteToolView> {
  @override
  Widget build(BuildContext context) {
    // Displays error message if the team does not yet have tools.
    if (getLoggedInTeam()!.getToolList().isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Tool Share')),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Delete Equipment', style: TextStyle(fontSize: 35)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              child: Text('Team ' +
                  getLoggedInTeam()!.getNumber().toString() +
                  ' does not yet have any tools added.'),
            ),
          ],
        ),
      );
    }
    // Displays the list of tools for potential removal.
    return Scaffold(
      appBar: AppBar(title: const Text('Tool Share')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(),
              child: Text('Delete Equipment', style: TextStyle(fontSize: 35)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Please select a tool to remove from the team:'),
                  DeleteToolViewModel.getTools(context, this),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
