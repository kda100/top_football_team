///helps assign string objects to each enum and helps with conversion of string format to enum object.

class EnumValues<T> {
  final Map<String, T> _map;
  final Map<T, String> _reverseMap;

  EnumValues(this._map)
      : _reverseMap = _map.map((key, value) => MapEntry(value, key));

  Map<T, String> get getTypeToValueMap {
    return _reverseMap;
  }

  Map<String, T> get getValueToTypeMap => _map;
}
