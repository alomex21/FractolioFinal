class AllergenController {
  final List<String> _allergens = [];

  List<String> getAllergens() {
    return List.unmodifiable(_allergens);
  }

  void addAllergen(String allergen) {
    _allergens.add(allergen);
  }

  void removeAllergen(int index) {
    _allergens.removeAt(index);
  }
}
