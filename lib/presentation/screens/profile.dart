// ignore_for_file: use_build_context_synchronously

import 'package:firfir_tera/models/User.dart';
import 'package:firfir_tera/presentation/services/auth_service.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, ref) {

    User user = ref.watch(userModelProvider).when(
      data: (body) {
        return body;
      },
      error:  (e,s) => throw(e),
      loading: (){
        return User(email: "noemail", id: '2', firstName: "ene", lastName: "das", role : "cook");
      }
    );
  
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
                  // backgroundImage: user.image != null ? NetworkImage(user.image) : AssetImage('assets/profile_pic/profile_2.jpg'),
                backgroundImage: AssetImage('assets/profile_pic/profile_2.jpg'),
              ),
              const SizedBox(height: 20),
               Text(
                user.firstName,
                style: const  TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
               Text(
                user.email,
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
                  sharedPreferences.clear();
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
               onPressed: () async {
  try {
    AuthService authInstance = AuthService();
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String? userId = sharedpref.getString('userId'); 
    
     // No need for 'await' here

    if (userId != null) {
      await authInstance.deleteUser(userId, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:  Text("User ID not found in SharedPreferences"),
      ));
      // Handle the case where userId is null
    }
  } catch (e) {
 ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error SharedPreferences"),
      ));  }
  
  // test();
},style: ButtonStyle(
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
