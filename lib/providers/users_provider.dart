import 'dart:convert';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firfir_tera/models/User.dart';

part 'users_provider.g.dart';

@riverpod
Future<List> allUsers(AllUsersRef ref) async {
  await initializeSharedPreferences();
  const String baseUrl = "https://2076-213-55-95-177.ngrok-free.app";
  final response = await http.get(
    Uri.parse('$baseUrl/user'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${sharedPreferences.getString('token')}',
    },
  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;

    return data
        .where(
            (element) => element['_id'] != sharedPreferences.getString("userId"))
        .map((e) => User.fromJson(e))
        .toList();
  } else {
    throw Exception("");
  }
}

@riverpod
class UserState extends _$UserState {
  @override
  User build() {
    return User(
        id: '1',
        email: "afdasfds",
        firstName: "nafga",
        lastName: "manda",
        role: "cook",
        image: "/assets/profile_pic/profile_2.jpg");
  }

  void setUser(User user) {
    state = user;
  }
}
