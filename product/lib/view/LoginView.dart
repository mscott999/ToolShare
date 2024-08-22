import '../viewmodel/LoginViewModel.dart';
import 'package:flutter/material.dart';

// Application page for logging in to preexisting teams' accounts.
class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel.init();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tool Share'),
        automaticallyImplyLeading: false,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        const Text('Sign in', style: TextStyle(fontSize: 35)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          // Team number (Username) textfield.
          child: TextField(
            onChanged: (String string) {
              LoginViewModel.setTargetNumber(string);
            },
            decoration: const InputDecoration(
              hintText: 'Team number',
              filled: true,
              fillColor: Colors.green,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
          // Team password textfield.
          child: TextField(
            onChanged: (String string) {
              LoginViewModel.setTargetPassword(string);
            },
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'Password',
              filled: true,
              fillColor: Colors.green,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Submit button.
            ElevatedButton(
              onPressed: () {
                LoginViewModel.attemptLogin(context);
              },
              child: const Text("Sign In"),
            ),
            // Add new team instead button.
            ElevatedButton(
              onPressed: () {
                LoginViewModel.routeToNewUser(context);
              },
              child: const Text("New Team"),
            ),
          ],
        ),
      ]),
    );
  }
}
