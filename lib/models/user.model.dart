class User {
  final String firstName;
  final String lastName;
  final String city;
  final String country;
  final String smallPictureUrl;
  User(
      {required this.firstName,
      required this.lastName,
      required this.city,
      required this.country,
      required this.smallPictureUrl});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['name']['first'] ?? '',
      lastName: map['name']['last'] ?? '',
      city: map['location']['city'] ?? '',
      country: map['location']['country'] ?? '',
      smallPictureUrl: map['picture']['thumbnail'] ?? '',
    );
  }
}
