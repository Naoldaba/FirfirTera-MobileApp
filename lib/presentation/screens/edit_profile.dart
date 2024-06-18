import 'package:firfir_tera/providers/profile_edit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditProfile extends ConsumerWidget {
  const EditProfile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileEditProvider);
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController bio = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             TextField(
              controller:name,
              decoration:  InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 20.0),         
            TextField(  
              controller: email,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: bio,
              decoration: const InputDecoration(labelText: 'Bio'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){

              ref.read(profileEditProvider.notifier).ovverideAll( {
                'name': name.text,
                'email': email.text,
                'bio': bio.text,
              }, context);
            }, child: const Text('Save'))
          ],
        ),
      ),
    );
  
  }
}
