import 'package:firfir_tera/presentation/services/auth_service.dart';
import 'package:firfir_tera/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firfir_tera/presentation/widgets/brand_promo.dart';


class Login extends ConsumerStatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  ConsumerState<Login> createState() => _LoginState();
}


class _LoginState extends ConsumerState<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selectedOption = ref.read(userProvider);
      ref.refresh(userProvider);
    });
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<bool?> _submit(context) async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      AuthService authService = AuthService();
      authService.login(email, password, context);
      return true;
    }
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    RegExp regex =
        RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (!regex.hasMatch(value)) {
      return 'Password must contain at least one letter,a number,a special char, and at least 8 chars';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 60),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BrandPromo(color: Colors.black),
                  const SizedBox(height: 80),
                  Text(
                    "Login to your Account",
                    style: GoogleFonts.firaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      prefixIcon:const  Icon(Icons.lock),
                      labelText: "Password",
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.circular(20),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                    // validator: _validatePassword
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: (){
                      
                      _submit(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.orange,
                      minimumSize: const Size(130, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ),
                    ),
                    child: const Text("Login"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? '),
                      GestureDetector(
                        onTap: () => context.go('/register_1'),
                        child: const MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child:  Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.orange,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
