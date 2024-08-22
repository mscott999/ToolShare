import 'dart:convert';

class Tool {
  // Number of tools avaliable for this tool type.
  final int _quantity;
  // Boolean list with a length of 7. Each index represents whether or not the tool is avaialable on that day of the week.
  final List<bool> _daysAvailable;
  // The title of the tool.
  final String _title;

  // Constructor for creating a new tool instance.
  Tool(this._quantity, this._daysAvailable, this._title);

  // Constructor for creating a new tool instance from a JSON text format.
  Tool.fromJson(Map<String, dynamic> json)
      : _quantity = int.parse(json['_quantity']),
        _daysAvailable = List<bool>.from(jsonDecode(json['_daysAvailable'])),
        _title = json['_title'];

  // Constructor for representing a Tool using a JSON text format.
  Map<String, dynamic> toJson() => {
        '_quantity': _quantity.toString(),
        '_daysAvailable': jsonEncode(_daysAvailable),
        '_title': _title,
      };

  // Method used for displaying tools in alphabetical order.
  int compareTo(Tool tool) {
    return _quantity.compareTo(tool.getQuantity());
  }

  // getter for the quantity of tools.
  int getQuantity() {
    return _quantity;
  }

  // getter for the days the tool is available for borrowing.
  List<bool> getDaysAvailable() {
    return _daysAvailable;
  }

  // getter for the name of the tool.
  String getTitle() {
    return _title;
  }
}
