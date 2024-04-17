import 'package:firfir_tera/presentation/screens/create_recipe_page.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/screens/discover.dart';
import 'package:firfir_tera/presentation/screens/profile.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: MotionTabBar(
          labels: const ["Discover", "Ingredients", "Profile"],
          icons: const [Icons.home, Icons.local_grocery_store, Icons.person],
          tabIconSelectedColor: Colors.orange,
          initialSelectedTab: "Discover",
          tabSize: 50,
          tabBarHeight: 60,
          textStyle: const TextStyle(color: Colors.grey),
          tabIconColor: Colors.grey,
          tabIconSize: 24,
          onTabItemSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const Discover();
      case 1:
        return CreateRecipe();
      case 2:
        return const Profile();
      default:
        return Container();
    }
  }
}
