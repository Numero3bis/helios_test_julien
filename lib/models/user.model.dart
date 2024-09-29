import 'dart:math';

class User {
  final String firstName;
  final String lastName;
  final String city;
  final String country;
  final String smallPictureUrl;
  final String largePictureUrl;
  final String crime;
  User(
      {required this.firstName,
      required this.lastName,
      required this.city,
      required this.country,
      required this.smallPictureUrl,
      required this.largePictureUrl,
      required this.crime});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        firstName: map['name']['first'] ?? '',
        lastName: map['name']['last'] ?? '',
        city: map['location']['city'] ?? '',
        country: map['location']['country'] ?? '',
        smallPictureUrl: map['picture']['thumbnail'] ?? '',
        largePictureUrl: map['picture']['large'] ?? '',
        crime: getRandomCrime());
  }

  static getRandomCrime() {
    List<String> crime = [
      'AWS UI/UX designer',
      "Tax evasion",
      "Fraude",
      "JavaScript dev",
      "Hacker",
      "Youtuber"
    ];
    return crime[Random().nextInt(crime.length)];
  }
}
