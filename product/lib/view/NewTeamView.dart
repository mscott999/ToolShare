import 'package:flutter/material.dart';
import '../viewmodel/NewTeamViewModel.dart';

// Application page for creating a new team into the applciation.
class NewTeamView extends StatelessWidget {
  const NewTeamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    NewTeamViewModel.init();
    return Scaffold(
        appBar: AppBar(title: const Text('Tool Share')),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('New Team', style: TextStyle(fontSize: 35)),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                // Text field for selecting the team's identifying number.
                child: TextField(
                  onChanged: (String string) {
                    NewTeamViewModel.setTargetNumber(string);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Team number',
                    filled: true,
                    fillColor: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                // Text field for selecting the team's password.
                child: TextField(
                  onChanged: (String string) {
                    NewTeamViewModel.setTargetPassword(string);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                // Text field for selecting the team's name.
                child: TextField(
                  onChanged: (String string) {
                    NewTeamViewModel.setTargetName(string);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Team name',
                    filled: true,
                    fillColor: Colors.green,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                // Text field for adding a short desctription of the team.
                child: TextField(
                  maxLines: null,
                  onChanged: (String string) {
                    NewTeamViewModel.setTargetDescription(string);
                  },
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    filled: true,
                    fillColor: Colors.green,
                  ),
                ),
              ),
              // Google map for picking the team's location. Tapping on the map acts as the submit button.
              NewTeamViewModel.getMap(context),
            ],
          ),
        ));
  }
}
