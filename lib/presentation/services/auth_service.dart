import 'dart:convert';
import 'package:firfir_tera/models/auth_response.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthService  {
  final String baseUrl ="https://e5c9-196-189-150-186.ngrok-free.app/auth";
  late SharedPreferences sharedPreferences ;
  Future<void> initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  AuthService();

  Future<void> login(String email, String password, BuildContext context) async {
    await initializeSharedPreferences();
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    ).timeout(const Duration(seconds: 300));
      print(response.statusCode);
      if (response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        final authResponse = AuthResponseModel(token: responseJson['token'], role: responseJson['role'][0], userId: responseJson['id']);
        saveUserToSharedPreferences(authResponse);
        context.go('/home');
        
    } else {
      SnackBar(content: Text(response.body));
    }
  }

  Future<void> saveUserToSharedPreferences(user) async {
    await sharedPreferences.setString('user_data', user);
  }
  


  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future registerUser(Map<String, String> data,  String? filePath,BuildContext context) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://e5c9-196-189-150-186.ngrok-free.app/auth/signup'));
    if (filePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
      // print(filePath);
      // print('trying to add file');
    }
    request.fields.addAll(data);
    final response = await request.send();
    if (response.statusCode == 201){
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);  
      final authResponse = AuthResponseModel(token: responseJson['token'], role: responseJson['role'][0], userId: responseJson['id']);
      // final authResponse = AuthResponseModel(token: responseJson['token'], role: responseJson['role'][0], userId: responseJson['id']);
        saveUserToSharedPreferences(authResponse);
        // ignore: use_build_context_synchronously
        context.go('/home');
    }
    else{
      SnackBar(content: Text(response.isRedirect.toString()));
      print(response.statusCode);
    }
    
   
  }

}
