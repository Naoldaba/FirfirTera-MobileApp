import 'package:firfir_tera/models/User.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_provider.g.dart';

List<User> allUsers = [
  User(id: 1, firstName: "Naol", lastName: "Daba", email: "afaklsdj@gmail.com"),
  User(
      id: 2,
      firstName: "Eyob",
      lastName: "Derese",
      email: "afaklsdj@gmail.com"),
  User(
      id: 3,
      firstName: "Anatoli",
      lastName: "Derese",
      email: "afaklsdj@gmail.com"),
  User(
      id: 4,
      firstName: "Aregawi",
      lastName: "Fikre",
      email: "afaklsdj@gmail.com"),
];

@riverpod
List<User> users(ref) {
  return allUsers;
}
