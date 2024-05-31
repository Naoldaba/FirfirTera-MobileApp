import 'package:firfir_tera/models/User.dart';
import 'package:firfir_tera/presentation/screens/admin.dart';
import 'package:firfir_tera/presentation/screens/create_recipe_page.dart';
import 'package:firfir_tera/presentation/screens/discover.dart';
import 'package:firfir_tera/presentation/screens/profile.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/providers/home_provider.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _HomeContent();
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userModelProvider);

    return userAsyncValue.when(
      data: (user) {
        final List<Widget> _pages = [const Discover()];

        final role = user.role;
        print(role);

        final List<BottomNavigationBarItem> _navItems = [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Discover',
          ),
        ];

        if (role == 'cook') {
          _pages.add(CreateRecipe());
          _pages.add(const Profile());
          _navItems.add(
            const BottomNavigationBarItem(
              icon: Icon(Icons.add_box_rounded),
              label: 'Add Recipe',
            ),
          );
          _navItems.add(
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          );
        } else if (role == 'admin') {
          _pages.add(AdminPanel());
          _navItems.add(
            const BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: 'Admin',
            ),
          );
        } else {
          _pages.add(const Profile());
          _navItems.add(const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ));
        }

        final selectedIndex = ref.watch(selectedIndexProvider);

        return Scaffold(
          body: _pages[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              ref.read(selectedIndexProvider.notifier).state = index;
            },
            items: _navItems,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.grey,
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
