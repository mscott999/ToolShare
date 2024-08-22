import 'package:flutter/material.dart';
import 'package:tool_share/main.dart';
import 'package:tool_share/viewmodel/SearchToolViewModel.dart';

// Application page for using a map to search for nearby locations with the desired tool.
class SearchToolView extends StatefulWidget {
  const SearchToolView({Key? key}) : super(key: key);

  @override
  _SearchToolViewState createState() => _SearchToolViewState();
}

class _SearchToolViewState extends State<SearchToolView> {
  // List of available tool names for populating the auto fill suggestions.
  static late List<String> _toolNames;

  // The google map loads the positions of teams upon first screen load.
  @override
  initState() {
    SearchToolViewModel.loadDefaultMarkers();
  }

  @override
  Widget build(BuildContext context) {
    _toolNames = SearchToolViewModel.getToolNames();
    return Scaffold(
      appBar: AppBar(title: const Text('Tool Share')),
      body: SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text('Search For Tool', style: TextStyle(fontSize: 35)),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Column(
              children: [
                // Text field for typing in the name of the desired tool.
                Autocomplete(
                  //Updates the list of recommended options as more letters are typed.
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return _toolNames.where((String _option) {
                      return _option
                          .contains(textEditingValue.text.toLowerCase());
                    });
                  },
                  // Attempts to search for the desired tool upon clicking one of the selections.
                  onSelected: (String string) {
                    SearchToolViewModel.searchForTool(
                        string,
                        0,
                        getLoggedInTeam()!.getLocation(),
                        double.infinity,
                        false,
                        this,
                        context);
                  },
                  // Parameter used to determine that the auto fill is controlled by a text field.
                  fieldViewBuilder: ((BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      decoration: const InputDecoration(
                        hintText: 'Search by tool name:',
                        filled: true,
                        fillColor: Colors.green,
                      ),
                      // Searches for the desired tool when the user enters in a word rather than clicking a suggestion.
                      onSubmitted: (String string) {
                        SearchToolViewModel.searchForTool(
                            string,
                            0,
                            getLoggedInTeam()!.getLocation(),
                            double.infinity,
                            false,
                            this,
                            context);
                      },
                    );
                  }),
                ),
                // Returns the actual google map with team markers present.
                SearchToolViewModel.getMap(context),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
