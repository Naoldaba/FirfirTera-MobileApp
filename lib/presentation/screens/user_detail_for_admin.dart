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
    final IsPromoted = ref.watch(isPromotedProvider);

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
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
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
                onPressed: () {
                  ref.read(isPromotedProvider.notifier).toggle();
                  _showSnackBar(
                    context,
                    IsPromoted
                        ? "User ${user.firstName} promoted to admin"
                        : "User ${user.firstName} demoted to regular user",
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: IsPromoted ? Colors.red : Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  IsPromoted ? 'Demote User' : 'Promote User',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  _showSnackBar(context, "User Deleted");
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
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
