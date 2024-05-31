import 'package:firfir_tera/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
                ref.watch(userModelProvider).when(
                  data: (user) {
                    if (user != null){
                      return '${user.firstName} ${user.lastName}';
                    }
                    else{
                      return 'No name';
                    }
                  },
                  loading: () => 'Loading...',
                  error: (error, stackTrace) {
                    return 'error';
                  } ,
                ),
                style: const  TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
               Text(
                ref.watch(userModelProvider).when(
                  data: (user){
                    if (user != null){
                      return user.email;
                    }
                    else{
                      return 'No email';
                    }
                  },
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
