import 'dart:convert';
import 'dart:io';
import 'package:firfir_tera/models/User.dart';
import 'package:firfir_tera/models/auth_response.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService  {

  final String baseUrl ="https://dummyjson.com/auth";
  late SharedPreferences sharedPreferences ;
  Future<void> initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  AuthService();

  Future<User?> login(String email, String password) async {
    await initializeSharedPreferences();
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': email, 'password': password}),
    );
      if (response.statusCode == 200) {
      saveUserToSharedPreferences(response.body);
      final resMap = json.decode(response.body) as Map<String, dynamic>;
      return User.fromJson(resMap);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> saveUserToSharedPreferences(user) async {
    await sharedPreferences.setString('user_data', user);

    
  }

    getCurrentUser() async { 
    await initializeSharedPreferences();
    final userString = sharedPreferences.getString('user_data');
    if (userString != null) {
           return true;
    }
     else {
      return false;
    }
  }

  Future<AuthResponse> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return AuthResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future registerUser(Map<String, String> data, ) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/register'));
    request.fields.addAll(data);
    // request.files.add(await http.MultipartFile.fromPath('image',));
    var response = await request.send();
    if (response.statusCode == 200) {

      print('Uploaded!');
    } else {
      print(response.statusCode);
      print('Failed to upload');
    }


  }
    

}
