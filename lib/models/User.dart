

import 'package:http/http.dart';

class User {
  final String id;
   final String firstName;
   String? lastName;
  final String email;
  final String role;
  final String? image;

  User(
      {
      required this.id,
       required this.firstName,
       this.lastName,
      required this.email,
      required this.role, 
      this.image  
    }
    );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'] ,
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        role: json['role'][0],
        image: json['image']
        );
  }
}
