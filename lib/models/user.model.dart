class User {
  final String firstName;
  final String lastName;
  User({
    required this.firstName,
    required this.lastName,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['name']['first'] ?? '',
      lastName: map['name']['last'] ?? '',
    );
  }
}
