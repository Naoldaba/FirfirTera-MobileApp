import 'dart:async';
import 'package:firfir_tera/models/User.dart';
import 'package:firfir_tera/presentation/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;

Future<void> initializeSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

Future<String?> checkUser() async {
  await initializeSharedPreferences();

  // sharedPreferences.clear();
  final userString = sharedPreferences.getString('token');
  return userString;
}

Future getSessionJson() async {
  await initializeSharedPreferences();
  final userString = sharedPreferences.getString('token');
  final role = sharedPreferences.getString('role');
  final id = sharedPreferences.getString('userId');
  return {'token': userString, 'role': role, 'id': id};
}

final userProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  print('userProvider called');
  final data = await getSessionJson();
  AuthService authInstance = AuthService();
  return await authInstance.getUser(data!['id']);
});

final userModelProvider = FutureProvider.autoDispose<User>((ref) async {
  print('userModelProvider called');
  final userAsyncValue = await ref.watch(userProvider.future);

  return User.fromJson(userAsyncValue);
});

final checkProvider = FutureProvider<String?>((ref) async {
  return await checkUser();
});
