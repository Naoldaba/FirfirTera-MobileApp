import 'package:firfir_tera/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/models/presentation/screens/create_recipe_page.dart';
import 'package:firfir_tera/models/presentation/screens/discover.dart';
import 'package:firfir_tera/models/presentation/screens/profile.dart';
import 'package:firfir_tera/models/presentation/screens/admin.dart';
import 'package:firfir_tera/providers/home_provider.dart';

class Home extends StatelessWidget {

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: _HomeContent(),
    );
  }
}

// ignore: must_be_immutable
class _HomeContent extends ConsumerWidget {
   bool isAdmin = false;

   _HomeContent({Key? key,}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    user.when(
      data: (data){
        if (data.role == 'admin'){
          isAdmin = true;
        }
        else{
          isAdmin = false;
        }
      }, 
     loading: (){
        return const Scaffold(body:  Center(child: CircularProgressIndicator.adaptive()));
      },
      error: (error, stackTrace) {
        return const Scaffold(
          body: Center(
            child: Text('An error occurred'),
          ),
        );
      }
      );

    final _pages = [
      const Discover(),
      const CreateRecipe(),
      isAdmin ? AdminPanel() : const Profile(),
    ];

    final _navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Discover',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_box_rounded),
        label: 'Add Recipe',
      ),
      BottomNavigationBarItem(
        icon: Icon(isAdmin ? Icons.admin_panel_settings : Icons.person),
        label: isAdmin ? 'Admin' : 'Profile',
      ),
    ];

    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          ref.read(selectedIndexProvider.notifier).state = index;
        },
        items: _navItems,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
