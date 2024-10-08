import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String baseUrl = "https://firfir-tera-backend.vercel.app";

  late SharedPreferences sharedPreferences;
  Future<void> initializeSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  AuthService();

  Future<void> login(
      String email, String password, BuildContext context) async {
    await initializeSharedPreferences();
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );
    print("successfully sent regitration form");
    print("status-code ${response.statusCode}");
    print(response.body);
    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      await saveUserToSharedPreferences(
          responseJson['token'], responseJson['role'][0], responseJson['id']);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text("Login failed, check your email or password, network")),
      );
    }
  }

  Future<void> saveUserToSharedPreferences(
      String token, String role, String userId) async {
    await initializeSharedPreferences();
    await sharedPreferences.clear();

    await sharedPreferences.setString('token', token);
    await sharedPreferences.setString('role', role);
    await sharedPreferences.setString('userId', userId);
  }

  Future registerUser(
      Map<String, String> data, String? filePath, BuildContext context) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/auth/signup'));
    if (filePath != null) {
      request.files.add(await http.MultipartFile.fromPath('image', filePath));
    }
    request.fields.addAll(data);
    final response = await request.send();
    print("successfully sent regitration form");
    print("status-code ${response.statusCode}");
    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);
      saveUserToSharedPreferences(
          responseJson['token'], responseJson['role'][0], responseJson['id']);
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration failed, check your network")),
      );
    }
  }

  Future<Map<String, dynamic>> getUser(String userId) async {
    await initializeSharedPreferences();
    final response = await http.get(
      Uri.parse('$baseUrl/user/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
      },
    );

    if (response.statusCode == 200) {
      print("returning decoded json obj");
      final jsond = jsonDecode(response.body);
      return jsond;
    } else {
      throw Exception('Faileddddd to load user');
    }
  }

  // Future editUser(String? id) async {
  //   await initializeSharedPreferences();

  //   return http.patch(
  //     Uri.parse('$baseUrl/user/$id'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
  //     },
  //     body: jsonEncode(json),
  //   );
  // }

  Future deleteUser(String? id, BuildContext context) async {
    await initializeSharedPreferences();

    http.delete(
      Uri.parse('$baseUrl/user/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
      },
    );
    await sharedPreferences.clear();
    context.go('/');
    return;
  }

  Future<void> logout(BuildContext context) async {
    await initializeSharedPreferences();
    await sharedPreferences.clear();
    context.go('/login');
  }

  Future<void> patchUser(Map<String, dynamic> data, BuildContext context) async {
    await initializeSharedPreferences();

    final userId = sharedPreferences.getString('userId');
    final token = sharedPreferences.getString('token');

    if (userId == null || token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not authenticated')),
      );
      return;
    }

    final res = await http.patch(
      Uri.parse('$baseUrl/user/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data), 
    );

    if (res.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Updated Successfully')),
      );
      context.go('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile Updation Failed: ${res.reasonPhrase}')),
      );
    }
  }


  Future<bool> changeRole(String role, String userId) async {
    await initializeSharedPreferences();
    final response = await http.patch(
      Uri.parse('$baseUrl/user/changeRole/$userId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
      },
      body: jsonEncode({
        'role': role,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> deleteGivenUser(String id, BuildContext context) async {
    await initializeSharedPreferences();

    final response = await http.delete(
      Uri.parse('$baseUrl/user/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
      },
    );

    if (response.statusCode != 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile Deletion Failed')),
      );
    }
  }
}
