import 'package:firfir_tera/models/User.dart';

class AuthResponseModel {
  final int? token;
  final String role;
  final String userId;

  AuthResponseModel({required this.token, required this.role, required this.userId});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'],
      role: json['role'][0],
      userId : json['id']
    );
  }
}
