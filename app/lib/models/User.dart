
class User {
  final String id;
  final String firstName;
  String? lastName;
  final String email;
  final String role;
  final String image;
  String? createdAt;
  String? updatedAt;
  String? version;

  User(
      {
      required this.id,
      required this.firstName,
      this.lastName,
      required this.email,
      required this.role, 
      required this.image,
      this.createdAt,
      this.updatedAt,
      this.version
    }
    );

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'] ,
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        role: json['role'][0],
        image: json['image'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        version: json['__v'].toString()
        );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName':firstName,
      'lastName':lastName,
      'image':image,
      'role':role,
      'email':email
    };
  }

}




