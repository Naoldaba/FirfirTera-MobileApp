
// Anatoli this is just for mocking, you need to implement the real provider

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firfir_tera/models/User.dart';

part 'users_provider.g.dart';

@riverpod
Future<List<User>> allUsers(AllUsersRef ref) async {
  final response = await http.get(Uri.parse(""));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception("");
  }
}

@riverpod
class UserState extends _$UserState {
  @override
  User build() {
    return User(
      id: 1,
      email: "afdasfds",
      firstName: "nafga",
      lastName: "manda",
      role: "normal",
    );
  }

  void setUser(User user) {
    state = user;
  }
}
