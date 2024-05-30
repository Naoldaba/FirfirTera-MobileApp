import 'dart:convert';
import 'package:firfir_tera/models/auth_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class AuthService  {
  final String baseUrl ="https://ee64-196-189-150-186.ngrok-free.app";
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
      if (response.statusCode == 201) {
        final responseJson = json.decode(response.body);
        saveUserToSharedPreferences(responseJson['token'], responseJson['role'], responseJson['id']);
        context.go('/home');
        
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.body)),
      );
    }
  }

  Future<void> saveUserToSharedPreferences(String token, String role, String userId) async {
    await initializeSharedPreferences();
    
    await sharedPreferences.setString('token', token);
    await sharedPreferences.setString('role', role);
    await sharedPreferences.setString('userId', userId);
    print('saved');
  }
  

  Future registerUser(Map<String, String> data,  String? filePath,BuildContext context) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/auth/signup'));
    if (filePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
    }
    request.fields.addAll(data);
    final response = await request.send();
    if (response.statusCode == 201){
        final responseBody = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseBody);  
        saveUserToSharedPreferences(responseJson['token'], responseJson['role'][0], responseJson['id']);

        // saveUserToSharedPreferences(responseJson);
        // context.go('/home');
    }
    else{
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response.statusCode.toString())),
      );
    }
  }

  Future<Map<String, dynamic>> getUser(String userId) async {
    print("here with" + userId);
    
  await initializeSharedPreferences();
  final response = await http.get(
    Uri.parse('$baseUrl/user/$userId'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
    },
  ).timeout(const Duration(seconds: 300));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load user');
  }
}

}


