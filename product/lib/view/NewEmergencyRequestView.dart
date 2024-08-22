import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../viewmodel/NewEmergencyRequestViewModel.dart';

// Application page for making a new emergency request for a tool. State is updated to reflect changes in the quantity picker.
class NewEmergencyRequestView extends StatefulWidget {
  const NewEmergencyRequestView({Key? key}) : super(key: key);

  @override
  _NewEmergencyRequestViewState createState() =>
      _NewEmergencyRequestViewState();
}

class _NewEmergencyRequestViewState extends State<NewEmergencyRequestView> {
  @override
  // Sets input variables to defualt state upon screen load.
  void initState() {
    NewEmergencyRequestViewModel.setTargetName('');
    NewEmergencyRequestViewModel.setTargetQuantity(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tool Share')),
      body: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text('New Emergency Request', style: TextStyle(fontSize: 35)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            // Textfield for choosing the tool's name.
            child: TextField(
              onChanged: (String string) {
                NewEmergencyRequestViewModel.setTargetName(
                    string.toLowerCase());
              },
              decoration: const InputDecoration(
                hintText: 'Name of Tool',
                filled: true,
                fillColor: Colors.green,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                const Text('Please select the quantity of tools:'),
                // Widget for selecting the quantity of tools needed.
                NumberPicker(
                  value: NewEmergencyRequestViewModel.getTargetQuantity(),
                  minValue: 1,
                  maxValue: 99,
                  step: 1,
                  itemCount: 3,
                  axis: Axis.horizontal,
                  onChanged: (value) {
                    setState(() =>
                        NewEmergencyRequestViewModel.setTargetQuantity(value));
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black26),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(),
              // Submit selection button.
              child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    NewEmergencyRequestViewModel.attemptNewRequest(context);
                  })),
        ]),
      ),
    );
  }
}
