import 'dart:async';
import 'dart:convert';
import 'package:firfir_tera/models/User.dart';
import 'package:firfir_tera/models/presentation/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sharedPreferences ;
 Future<void> initializeSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

Future <String?> checkUser() async {
  await initializeSharedPreferences();
  final userString = sharedPreferences.getString('token');
  return userString ;
}

Future  getSessionJson() async {
  await initializeSharedPreferences();
  final userString = sharedPreferences.getString('token');
  final role = sharedPreferences.getString('role');
  final id = sharedPreferences.getString('userId');
  return {
    'token': userString,
    'role': role,
    'id': id
  };
  
}


final userProvider = FutureProvider((ref) async {
  final data = await getSessionJson();
  AuthService authInstance  = AuthService();
  final myUser = authInstance.getUser(data!['id']).then((value) => User.fromJson(value));
  return myUser;
}
);





final checkProvider = FutureProvider<String?>((ref) async {
      return await checkUser();
});


