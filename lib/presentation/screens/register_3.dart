
import 'package:firfir_tera/presentation/services/auth_service.dart';
import 'package:firfir_tera/providers/registration_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class Register_3 extends ConsumerStatefulWidget {
  const Register_3({super.key});

  @override
  ConsumerState<Register_3> createState() => _Register_3State();
}

class _Register_3State extends ConsumerState<Register_3> {
  String? _imageData;
  String? _imageName;
  String? _imagePath;

  Future<String> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      final base64Image = base64Encode(bytes);
      setState(() {
        _imageData = base64Image;
        _imageName = pickedImage.path.split('/').last;
      });
      return pickedImage.path;
    }
    else{
      throw Exception('No image selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    
    void prepareData(context) async {
      final firstPage = ref.read(myfirstPageMapProvider);
      final secondPage = ref.read(mysecondPageMapProvider);
      Map<String, String> totalData = {...firstPage, ...secondPage};
      _imagePath ??= await _getImage();
      final authInstance = AuthService();     
      authInstance.registerUser(totalData, _imagePath, context);
    }
    

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
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.go('/register_2'),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                    color: Colors.white,
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Column(
                children: [
                  Text(
                    "Upload Your Photo Profile",
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  Text(
                    "The Photo Will be Displayed in Your Account Profile",
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
              GestureDetector(
                onTap: _getImage,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    width: 200,
                    height: 200,
                    
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: _imageData != null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              Image.memory(
                                base64Decode(_imageData!),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ],
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Upload",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                     prepareData(context);
                      // Navigator.pushReplacementNamed(context, '/register_2');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                      minimumSize:
                          MaterialStateProperty.all(const Size(130, 60)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      "Finish",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
