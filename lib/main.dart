import 'package:firfir_tera/presentation/screens/admin.dart';
import 'package:firfir_tera/presentation/screens/register_3.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/screens/home.dart';
import 'package:firfir_tera/presentation/screens/login.dart';
import 'package:firfir_tera/presentation/screens/register_1.dart';
import 'package:firfir_tera/presentation/screens/register_2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firfir_tera/presentation/screens/detailed_recipe_view.dart';
import 'package:firfir_tera/presentation/screens/onboarding_1.dart';
import 'package:firfir_tera/presentation/screens/onboarding_2.dart';
import 'package:firfir_tera/presentation/screens/onboarding_3.dart';

import 'presentation/screens/comment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme:
              GoogleFonts.firaSansTextTheme(Theme.of(context).textTheme)),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnBoarding_1(),
        '/onboarding_2': (context) => const OnBoarding_2(),
        '/onboarding_3': (context) => const OnBoarding_3(),
        '/home': (context) => const Home(),
        '/login': (context) => const Login(),
        '/register_1': (context) => const Register_1(),
        '/register_2': (context) => const Register_2(),
        '/register_3': (context) => const Register_3(),
        '/home/detailed_view': (context) => const DetailedView(),
        '/admin': (context) => AdminPanel()
        '/create_recipe':(context)=>CreateRecipe(),
        '/comment':(context)=>CreateComment(),
      },
    );
  }
}
