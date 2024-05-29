import 'package:firfir_tera/providers/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// ignore: camel_case_types
class Register_2 extends ConsumerStatefulWidget {
  const Register_2({super.key});

  @override
  ConsumerState<Register_2> createState() => _Register_2State();
}

class _Register_2State extends ConsumerState<Register_2> {
  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _bio = TextEditingController();

  void _submit() {
    String firstName = _firstName.text;
    String lastName = _lastName.text;
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _bio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body:  Flexible(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/log_reg_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () 
                          {
                            context.go('/register_1');
                            
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 40,
                          ),
                          color: Colors.white,
                        )
                      ],
                    ),
            
                    const Column(
                      children: [
                        Text(
                          "Fill in Your Bio to get Started",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        Text(
                          "The data will be displayed in your account profile ",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 70,
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
                          TextField(
                            controller: _firstName,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "first name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                  right: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextField(
                            controller: _lastName,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "last name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                  right: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                              controller: _bio,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.message),
                                  labelText: 'bio',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20),
                                    right: Radius.circular(20),
                                  )))),
                          const SizedBox(height: 50),
                          ElevatedButton(
                            onPressed: () {
                              Map<String, dynamic > page = {
                                'firstName': _firstName.text,
                                'lastName': _lastName.text,
                                'bio': _bio.text,
                              };
                              ref.read(registerTwoProvider.notifier).addValue(page);
                              context.go('/register_3');
                            } ,
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
