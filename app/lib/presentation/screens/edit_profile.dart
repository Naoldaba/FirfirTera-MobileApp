import 'package:firfir_tera/providers/profile_edit_provider.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;

  @override
  void initState() {
    super.initState();
    final profileState = ref.read(profileEditProvider);
    firstNameController = TextEditingController(text: profileState['firstName'] ?? '');
    lastNameController = TextEditingController(text: profileState['lastName'] ?? '');
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(profileEditProvider);

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
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                ref.read(profileEditProvider.notifier).overrideAll({
                  'firstName': firstNameController.text,
                  'lastName': lastNameController.text,
                }, context);
                await ref.watch(userProvider.future);
                context.go('/home');
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
