import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class CreateRecipe extends StatefulWidget {
  const CreateRecipe({super.key});

  @override
  State<CreateRecipe> createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    _controllers.add(TextEditingController());
    _controllers.add(TextEditingController());
    _controllers.add(TextEditingController());
    _controllers.add(TextEditingController());
    _controllers.add(TextEditingController());
    _controllers.add(TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addLine() {
    setState(() {
      _controllers.add(TextEditingController());
      _controllers.add(TextEditingController());
    });
  }

  void _removeLine(int index) {
    setState(() {
      _controllers.removeAt(index);
      _controllers.removeAt(index);
    });
  }

  final _tempImage = ClipRRect(
    borderRadius: BorderRadius.circular(
        10.0),
    child: Image.asset(
      'assets/images/kikil.jpg',
      fit: BoxFit.cover,
    ),
  );
  PickedFile? _image;
  final ImagePicker _picker = ImagePicker();
  final primeryColor = Colors.orange;

  // ignore: non_constant_identifier_names
  void take_photo(ImageSource source) async {
    
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile;
      }
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Text(
            'Choose Image',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    
                    take_photo(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera')),
              TextButton.icon(
                  onPressed: () {
                    
                    take_photo(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery'))
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Create Recipe',
                    style: GoogleFonts.firaSans(fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                       
                        child: _image == null
                            ? _tempImage
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.file(File(_image!.path),
                                    fit: BoxFit.cover)),
                      ),
                      Positioned(
                        top: 10,
                        right: 20,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: primeryColor,
                          ),
                          onPressed: () {
                            
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) {
                                  return bottomSheet();
                                });
                          },
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        prefixIcon: Icon(
                          Icons.local_dining,
                          color: primeryColor,
                        ),
                        prefixText: "Recipe Name    ",
                        prefixStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        hintText: "Enter Recipe Name",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primeryColor))),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        prefixIcon: Icon(
                          Icons.person,
                          color: primeryColor,
                        ),
                        prefixText: "Serves    ",
                        prefixStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        hintText: "Enter Number of Serves",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primeryColor))),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(20),
                        prefixIcon: Icon(
                          Icons.access_time,
                          color: primeryColor,
                        ),
                        prefixText: "Cooking Time    ",
                        prefixStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        hintText: "Enter Cooking Time in Minutes",
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: primeryColor))),
                  ),
                  const SizedBox(height: 20),
                  const Text("Ingredients",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Container(
                    height: 250,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: _controllers.length,
                            itemBuilder: (context, index) {
                              if (index.isOdd) {
                                return const SizedBox(height: 8);
                              }
                              final controller = _controllers[index];
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      controller: controller,
                                      decoration: InputDecoration(
                                        hintText:
                                            'Ingredient ${index ~/ 2 + 1}',
                                        border: OutlineInputBorder(
                                          borderSide:
                                              const BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: TextField(
                                      controller: _controllers[index + 1],
                                      decoration: InputDecoration(
                                          hintText: 'weight',
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              borderSide: BorderSide(
                                                  color:
                                                      Colors.grey.shade100))),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.remove_circle),
                                    onPressed: () => _removeLine(index),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: _addLine,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 30,
                              ),
                              SizedBox(width: 8),
                              Text(
                                "Add Ingredient",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: primeryColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Stack(
                        children: <Widget>[
                          // Your other widgets go here
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 50.0, // You can adjust this as needed
                              width: MediaQuery.of(context)
                                  .size
                                  .width, // This will make the container full width
                              // Add your desired color
                              child: const Center(child: Text('Save My Recipe')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
