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

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      final bytes = await pickedImage.readAsBytes();
      final base64Image = base64Encode(bytes);
      setState(() {
        _imageData = base64Image;
        _imageName = pickedImage.path.split('/').last;
        _imagePath = pickedImage.path; // Save the image path
      });
    } else {
      throw Exception('No image selected');
    }
  }

  void prepareData(BuildContext context) async {
    final firstPage = ref.read(myfirstPageMapProvider);
    final secondPage = ref.read(mysecondPageMapProvider);
    Map<String, String> totalData = {...firstPage, ...secondPage};

    if (_imagePath == null) {
      await _getImage();
    }

    if (_imagePath != null) {
      final authInstance = AuthService();
      authInstance.registerUser(totalData, _imagePath!, context);
    } else {
      // Handle the case where no image was selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
    }
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
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.memory(
                              base64Decode(_imageData!),
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
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
