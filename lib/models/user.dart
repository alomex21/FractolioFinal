class User {
  final String id;
  final String fullName;
  final String email;
  final String joinedDate;
  final String dietaryPreferences;

  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.joinedDate,
      required this.dietaryPreferences});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        joinedDate = data['joinedDate'],
        dietaryPreferences = data['dietaryPreferences'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'joinedData': joinedDate,
      'dietaryPreferences': dietaryPreferences,
    };
  }
}
