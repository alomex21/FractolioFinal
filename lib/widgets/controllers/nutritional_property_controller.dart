class NutritionalPropertyController {
  final Map<String, String> _nutritionalValues = {};

  Map<String, String> getPropertyValues() {
    return Map.unmodifiable(_nutritionalValues);
  }

  void addNutritionalValue(String property, String value) {
    _nutritionalValues[property] = value;
  }

  void removeNutritionalValue(String key) {
    _nutritionalValues.remove(key);
  }
}
