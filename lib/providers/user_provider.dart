import 'package:firfir_tera/models/User.dart';
import 'package:firfir_tera/presentation/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

class UserNotifier extends ChangeNotifier {
  User? user;
  UserNotifier({this.user});
}

final userProvider = ChangeNotifierProvider<UserNotifier>((ref) {
  final authService = ref.read(authServiceProvider);
  final currUser = authService.getCurrentUser();
  return UserNotifier(user: currUser as User);
});