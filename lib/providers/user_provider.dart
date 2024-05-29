import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';


late SharedPreferences sharedPreferences ;
 Future<void> initializeSharedPreferences() async {
  sharedPreferences = await SharedPreferences.getInstance();
}

Future <String?> checkUser() async {
  await initializeSharedPreferences();
  final userString = sharedPreferences.getString('user_data');
  return userString ;
}

final userCheckProvider = FutureProvider<String?>((ref) async {
      return await checkUser();
});
