import 'package:firfir_tera/presentation/screens/admin.dart';
import 'package:firfir_tera/presentation/screens/comment.dart';
import 'package:firfir_tera/presentation/screens/create_recipe_page.dart';
import 'package:firfir_tera/presentation/screens/detailed_recipe_view.dart';
import 'package:firfir_tera/presentation/screens/home.dart';
import 'package:firfir_tera/presentation/screens/login.dart';
import 'package:firfir_tera/presentation/screens/new_admin.dart';
import 'package:firfir_tera/presentation/screens/onboarding_1.dart';
import 'package:firfir_tera/presentation/screens/onboarding_2.dart';
import 'package:firfir_tera/presentation/screens/onboarding_3.dart';
import 'package:firfir_tera/presentation/screens/register_1.dart';
import 'package:firfir_tera/presentation/screens/register_2.dart';
import 'package:firfir_tera/presentation/screens/register_3.dart';
import 'package:firfir_tera/presentation/screens/user_detail_for_admin.dart';
import 'package:firfir_tera/models/User.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AuthChecker(),
          routes: [
            GoRoute(
              path: 'onboarding_2',
              builder: (context, state) => const OnBoarding_2(),
            ),
            GoRoute(
              path: 'onboarding_3',
              builder: (context, state) => const OnBoarding_3(),
            ),
            GoRoute(
              path: 'home',
              builder: (context, state) =>  const Home(isAdmin: false),
              routes: [
                GoRoute(
                  path: 'detailed_view',
                  builder: (context, state) => const DetailedView(),
                ),
                GoRoute(
                  path: 'create_recipe',
                  builder: (context, state) => const CreateRecipe(),
                ),
                GoRoute(
                  path: 'comment',
                  builder: (context, state) => const CreateComment(),
                ),
              ],
            ),
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
            GoRoute(
              path: 'admin',
              builder: (context, state) => AdminPanel(),
              routes: [
                GoRoute(
                  path: 'add_admin',
                  builder: (context, state) => const AddAdminDialog()
                ),
                GoRoute(
                  path: 'user_details',
                  builder: (context, state) {
                    final user = state.extra as User;
                    return UserDetails(user: user);
                  }
                ),
              ]
            ),
          ]
        ),
      ],
    );


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: _router,
    );
  }
}


class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return user != null ? Container() : OnBoarding_1();
  }
}