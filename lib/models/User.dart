

class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String role;

  User({required this.id, required this.email , required this.firstName, required this.lastName, this.role = 'normal'});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      role: json['role'][0]
    );
  }

}


