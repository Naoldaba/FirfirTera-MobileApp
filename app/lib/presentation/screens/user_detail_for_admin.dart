import 'package:firfir_tera/presentation/services/auth_service.dart';
import 'package:firfir_tera/providers/discover_provider.dart';
import 'package:firfir_tera/providers/home_provider.dart';
import 'package:firfir_tera/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/models/User.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/providers/user_details_provider.dart';
import 'package:go_router/go_router.dart';

class UserDetails extends ConsumerWidget {
  final User user;

  UserDetails({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IsSuccess = ref.watch(isSuccessProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "User Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: Image.network(user.image)),
              const SizedBox(height: 20),
              Text(
                '${user.firstName} ${user.lastName}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                user.email,
                style: const TextStyle(fontSize: 18),
              ),
              SizedBox(height: 40),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  AuthService authService = AuthService();
                  String next = "admin";
                  if (user.role == "admin") {
                    next = "normal";
                  }
                  bool ans = await authService.changeRole(next, user.id);

                  ref.read(isSuccessProvider.notifier).changeState(ans);
                  _showSnackBar(
                    context,
                    IsSuccess
                        ? "Successully changed role"
                        : "Unable to change role",
                  );
                  ref.refresh(allUsersProvider);
                  context.go('/home/admin');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      user.role == 'admin' ? Colors.red : Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  user.role == 'admin' ? 'Demote User' : 'Promote User',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  _showSnackBar(context, "User Deleted");
                  AuthService authService = AuthService();
                  await authService.deleteGivenUser(user.id, context);

                  ref.read(selectedIndexProvider.notifier).state = 1;
                  ref.refresh(allUsersProvider);
                  context.go('/home');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Delete User",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
