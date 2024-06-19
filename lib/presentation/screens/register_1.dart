import 'package:firfir_tera/providers/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/widgets/brand_promo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

enum UserType { customer, cook }

// ignore: camel_case_types
class Register_1 extends ConsumerStatefulWidget {
  const Register_1({Key? key}) : super(key: key);
  @override
  ConsumerState<Register_1> createState() => _Register_1State();

}


// ignore: camel_case_types
class _Register_1State extends ConsumerState<Register_1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  UserType _userType = UserType.customer;

  String? _validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      RegExp regex = RegExp(r'^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      if (!regex.hasMatch(value)) {
        return 'Password must contain at least one letter, one number, one special character, and be at least 8 characters long';
      }
      return null;
  }

  @override
  Widget build(BuildContext context) {
    final pageValue = ref.read(registerOneProvider);

    return Scaffold(
      extendBody: true,
      body:Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/log_reg_background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const BrandPromo(color: Colors.white),
                      const SizedBox(height: 15),
                      Text(
                        "Sign Up for free ",
                        style: GoogleFonts.firaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 30),
                            DropdownButtonFormField<UserType>(
                              value: _userType,
                              onChanged: (newValue) {
                                setState(() {
                                  _userType = newValue!;
                                });
                              },
                              items: UserType.values.map((UserType type) {
                                return DropdownMenuItem<UserType>(
                                  value: type,
                                  child: Text(
                                    type == UserType.customer
                                        ? 'Customer'
                                        : 'Cook',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: "User Type",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _emailController,
                              decoration:   const InputDecoration(
                                labelText: 'email',
                                border:   OutlineInputBorder(
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
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                labelText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20),
                                    right: Radius.circular(20),
                                  ),
                                ),
                              ),
                              validator: _validatePassword
                            ),
                            const SizedBox(height: 30),
                            ElevatedButton(
                              onPressed: () {

                                if (_formKey.currentState!.validate()) {
                                  Map<String, dynamic> dataOfPage;
                                  dataOfPage = {
                                    'email': _emailController.text,
                                    'password': _passwordController.text,
                                    'role': _userType == UserType.customer ? 'normal' : 'cook',
                                  };  
                                  ref.read(registerOneProvider.notifier).addValue(dataOfPage);
                                  context.go('/register_2');
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange),
                                minimumSize:
                                    MaterialStateProperty.all(const Size(130, 60)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                              ),
                              child: const Text("Next"),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Already have an account? '),
                                TextButton(
                                  onPressed: () {
                                    context.go('/login');
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
