import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:tool_share/viewmodel/AddToolViewModel.dart';

// Application page for adding a new tool to the team's list of tools for lending.
class AddToolView extends StatefulWidget {
  const AddToolView({Key? key}) : super(key: key);

  @override
  _AddToolViewState createState() => _AddToolViewState();
}

// Default state of the page. Changes when the horizontal number picker is altered.
class _AddToolViewState extends State<AddToolView> {
  @override
  // Sets input variables to defualt state upon screen load.
  void initState() {
    AddToolViewModel.setTargetName('');
    AddToolViewModel.setTargetQuantity(2);
    AddToolViewModel.setTargetSunday(false);
    AddToolViewModel.setTargetMonday(false);
    AddToolViewModel.setTargetTuesday(false);
    AddToolViewModel.setTargetWednesday(false);
    AddToolViewModel.setTargetThursday(false);
    AddToolViewModel.setTargetFriday(false);
    AddToolViewModel.setTargetSaturday(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tool Share')),
      body: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text('Add Tool To Team', style: TextStyle(fontSize: 35)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            // Tool Name TextField.
            child: TextField(
              onChanged: (String string) {
                AddToolViewModel.setTargetName(string.toLowerCase());
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
                // Tool Quantity Picker.
                NumberPicker(
                  value: AddToolViewModel.getTargetQuantity(),
                  minValue: 1,
                  maxValue: 99,
                  step: 1,
                  itemCount: 3,
                  axis: Axis.horizontal,
                  onChanged: (value) {
                    setState(() => AddToolViewModel.setTargetQuantity(value));
                  },
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.black26),
                  ),
                ),
              ],
            ),
          ),
          const Text(
            'Please select which days of the week the tool is avaliable for lending:',
            textAlign: TextAlign.center,
          ),
          // Days of the week available picker.
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Sunday:'),
                        Checkbox(
                            tristate: false,
                            value: AddToolViewModel.getTargetSunday(),
                            onChanged: (value) {
                              setState(() =>
                                  AddToolViewModel.setTargetSunday(value!));
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Monday:'),
                        Checkbox(
                            tristate: false,
                            value: AddToolViewModel.getTargetMonday(),
                            onChanged: (value) {
                              setState(() =>
                                  AddToolViewModel.setTargetMonday(value!));
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Tuesday:'),
                        Checkbox(
                            tristate: false,
                            value: AddToolViewModel.getTargetTuesday(),
                            onChanged: (value) {
                              setState(() =>
                                  AddToolViewModel.setTargetTuesday(value!));
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Wednesday:'),
                        Checkbox(
                            tristate: false,
                            value: AddToolViewModel.getTargetWednesday(),
                            onChanged: (value) {
                              setState(() =>
                                  AddToolViewModel.setTargetWednesday(value!));
                            }),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Thursday:'),
                        Checkbox(
                            tristate: false,
                            value: AddToolViewModel.getTargetThursday(),
                            onChanged: (value) {
                              setState(() =>
                                  AddToolViewModel.setTargetThursday(value!));
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Friday:'),
                        Checkbox(
                            tristate: false,
                            value: AddToolViewModel.getTargetFriday(),
                            onChanged: (value) {
                              setState(() =>
                                  AddToolViewModel.setTargetFriday(value!));
                            }),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Saturday:'),
                        Checkbox(
                            tristate: false,
                            value: AddToolViewModel.getTargetSaturday(),
                            onChanged: (value) {
                              setState(() =>
                                  AddToolViewModel.setTargetSaturday(value!));
                            }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Add tool submit button.
          Padding(
              padding: const EdgeInsets.symmetric(),
              child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    AddToolViewModel.attemptAdd(context);
                  })),
        ]),
      ),
    );
  }
}
