

class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        role: json['role']);
  }
}
