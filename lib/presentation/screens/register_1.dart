import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/widgets/brand_promo.dart';
import 'package:google_fonts/google_fonts.dart';

enum UserType { customer, cook }

class Register_1 extends StatefulWidget {
  const Register_1({super.key});

  @override
  State<Register_1> createState() => _Register_1State();
}

class _Register_1State extends State<Register_1> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  UserType _userType = UserType.customer;

  void _submit() {
    String email = _email.text;
    String password = _password.text;
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/log_reg_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const BrandPromo(color: Colors.white),
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Sign Up for free",
                    style: GoogleFonts.firaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30.0,
                        ),
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
                                    ? 'I am a Customer'
                                    : 'I am a Cook',
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
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
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextField(
                          controller: _email,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: "email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextField(
                          controller: _password,
                          obscureText: true,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            labelText: "password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            _submit();
                            Navigator.pushReplacementNamed(
                                context, '/register_2');
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.orange),
                            minimumSize:
                                MaterialStateProperty.all(const Size(130, 60)),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Next",
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, '/login');
                              },
                              child: Text('Login',
                                  style: TextStyle(color: Colors.orange)),
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
    );
  }
}
