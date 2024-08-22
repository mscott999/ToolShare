class EmergencyRequest {
  // String indicating the name of the desired tool.
  final String _name;
  // Quantity desired of the requested tool.
  final int _quantity;

  // Constructor for initializing new emergency requests.
  EmergencyRequest(this._name, this._quantity);

  // Constructor for initializing new emergency requests from JSON text format.
  EmergencyRequest.fromJson(Map<String, dynamic> json)
      : _name = json['_name'],
        _quantity = int.parse(json['_quantity']);

  // Converts an EmergencyRequest to JSON text format for saving.
  Map<String, dynamic> toJson() => {
        '_name': _name,
        '_quantity': _quantity.toString(),
      };

  // Getter for accessing the name of the emergency request.
  String getName() {
    return _name;
  }

  // Getter for accessing the quantity of the emergency request.
  int getQuantity() {
    return _quantity;
  }
}
