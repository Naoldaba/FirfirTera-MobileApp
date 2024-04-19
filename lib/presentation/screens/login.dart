import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firfir_tera/presentation/widgets/brand_promo.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email_controller = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email_controller.dispose();
    _password.dispose();
    super.dispose();
  }

  void _submit() {
    String email = _email_controller.text;
    String password = _password.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BrandPromo(
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Text("Login to your Account",
                        style: GoogleFonts.firaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        )),
                    Container(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30.0,
                          ),
                          TextField(
                            controller: _email_controller,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                labelText: 'email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 20.0,
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
                                        right: Radius.circular(20)))),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _submit;
                              Navigator.pushReplacementNamed(context, '/home');
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.orange),
                                minimumSize: MaterialStateProperty.all(
                                    const Size(130, 60)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0)))),
                            child: const Text(
                              "Login",
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have Account? '),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/register_1');
                                },
                                child: const MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        color: Colors.orange,
                                      ),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            )));
  }
}
