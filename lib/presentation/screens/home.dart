import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/presentation/screens/create_recipe_page.dart';
import 'package:firfir_tera/presentation/screens/discover.dart';
import 'package:firfir_tera/presentation/screens/profile.dart';
import 'package:firfir_tera/presentation/screens/admin.dart';
import 'package:firfir_tera/providers/home_provider.dart';

class Home extends StatelessWidget {
  final bool isAdmin;

  const Home({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: _HomeContent(isAdmin: isAdmin),
    );
  }
}

class _HomeContent extends ConsumerWidget {
  final bool isAdmin;

  const _HomeContent({Key? key, required this.isAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _pages = [
      Discover(),
      CreateRecipe(),
      isAdmin ? AdminPanel() : Profile(),
    ];

    final _navItems = [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Discover',
      ),
      BottomNavigationBarItem(
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
          ref.read(selectedIndexProvider.notifier).state = index;
        },
        items: _navItems,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
