import 'package:firfir_tera/presentation/screens/admin.dart';
import 'package:firfir_tera/presentation/screens/comment.dart';
import 'package:firfir_tera/presentation/screens/create_recipe_page.dart';
import 'package:firfir_tera/presentation/screens/detailed_recipe_view.dart';
import 'package:firfir_tera/presentation/screens/edit_profile.dart';
import 'package:firfir_tera/presentation/screens/edit_recipe.dart';
import 'package:firfir_tera/presentation/screens/home.dart';
import 'package:firfir_tera/presentation/screens/login.dart';
import 'package:firfir_tera/presentation/screens/new_admin.dart';
import 'package:firfir_tera/presentation/screens/onboarding_1.dart';
import 'package:firfir_tera/presentation/screens/onboarding_2.dart';
import 'package:firfir_tera/presentation/screens/onboarding_3.dart';
import 'package:firfir_tera/presentation/screens/profile.dart';
import 'package:firfir_tera/presentation/screens/register_1.dart';
import 'package:firfir_tera/presentation/screens/register_2.dart';
import 'package:firfir_tera/presentation/screens/register_3.dart';
import 'package:firfir_tera/presentation/screens/user_detail_for_admin.dart';
import 'package:firfir_tera/models/User.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firfir_tera/models/Recipe.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => const OnBoarding_1(),
        routes: [
          GoRoute(
            path: 'onboarding_2',
            builder: (context, state) => OnBoarding_2(),
          ),
          GoRoute(
            path: 'onboarding_3',
            builder: (context, state) => OnBoarding_3(),
          ),
          GoRoute(
            path: 'home',
            builder: (context, state) => Home(),
            routes: [
              GoRoute(
                path: 'detailed_view',
                builder: (context, state) {
                  final recipe = state.extra as Recipe;
                  return DetailedView(recipe);
                },
                routes: [
                  GoRoute(
                    path: 'comment',
                    builder: (context, state) {
                      final recipe = state.extra as Recipe;
                     
                      return CommentScreen(
                        recipe: recipe,
                      );
                    },
                  ),
                  GoRoute(
                    path: 'edit_recipe',
                    builder: (context, state) {
                      final recipe = state.extra as Recipe;
                      return EditRecipeScreen(recipe: recipe);
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'create_recipe',
                builder: (context, state) => CreateRecipe(),
              ),
              GoRoute(
                path: 'admin',
                builder: (context, state) => AdminPanel(),
                routes: [
                  GoRoute(
                    path: 'add_admin',
                    builder: (context, state) => const AddAdminDialog(),
                  ),
                  GoRoute(
                    path: 'user_details',
                    builder: (context, state) {
                      final user = state.extra as User;
                      
                      return UserDetails(user: user);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
              path: 'edit_profile',
              builder: (context, state) => EditProfile(),
              routes: [
                GoRoute(
                  path: 'profile',
                  builder: (context, state) => Profile(),
                )
              ]),
          GoRoute(
            path: 'login',
            builder: (context, state) => const Login(),
          ),
          GoRoute(
            path: 'register_1',
            builder: (context, state) => const Register_1(),
          ),
          GoRoute(
            path: 'register_2',
            builder: (context, state) => const Register_2(),
          ),
          GoRoute(
            path: 'register_3',
            builder: (context, state) => const Register_3(),
          ),
        ]),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: _router,
    );
  }
}
