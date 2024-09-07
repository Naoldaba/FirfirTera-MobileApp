import 'package:firfir_tera/providers/profile_edit_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditProfile extends ConsumerWidget {
  const EditProfile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileEditProvider);
    TextEditingController firstName = TextEditingController();
    TextEditingController lastName = TextEditingController();

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
              controller: firstName,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: lastName,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
                onPressed: () {
                  ref.read(profileEditProvider.notifier).ovverideAll({
                    'firstName': firstName.text,
                    'lastName': lastName.text,
                  }, context);
                },
                child: const Text('Save'))
          ],
        ),
      ),
    );
  }
}
