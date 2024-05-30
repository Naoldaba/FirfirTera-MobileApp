import 'package:firfir_tera/providers/user_provider.dart';
import 'package:firfir_tera/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, ref) {
  
      return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/profile_pic/profile_2.jpg'),
              ),
              const SizedBox(height: 20),
               Text(
                ref.watch(userProvider).when(
                  data: (user) => '${user.firstName} ${user.lastName}',
                  loading: () => 'Loading...',
                  error: (error, stackTrace) => 'error',
                ),
                style: const  TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
               Text(
                ref.watch(userProvider).when(
                  data: (user) => user.email,
                  loading: () => 'Loading...',
                  error: (error, stackTrace) => 'Error',
                ),
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EditProfile()),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    minimumSize: MaterialStateProperty.all(const Size(90, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)))),
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {
                  sharedPreferences.  clear();
                  print("loggin out");
                  context.go('/login');
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(90, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)))),
                child: const Text('Log Out', style: TextStyle(color: Colors.red)),
              ),
              const SizedBox(height: 10,),
              OutlinedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    minimumSize: MaterialStateProperty.all(const Size(90, 40)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)))),
                child: const Text('Delete', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
