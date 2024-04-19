// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
  List<TextEditingController> _controllers = [];

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
    _controllers.forEach((controller) => controller.dispose());
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
        10.0), // Adjust the radius to get the curve you want
    child: Image.asset(
      'assets/images/kikil.jpg',
      fit: BoxFit.cover,
    ),
  );
  PickedFile? _image;
  final ImagePicker _picker = ImagePicker();
  final primeryColor = Colors.orange;

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
      margin: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Choose Image',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    // Add your logic here
                    take_photo(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              TextButton.icon(
                  onPressed: () {
                    // Add your logic here
                    take_photo(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery'))
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
                  Row(
                    children: [
                      Icon(Icons.arrow_back),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Create Recipe',
                    style: GoogleFonts.firaSans(fontSize: 40),
                  ),
                  SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        // ignore: unnecessary_null_comparison
                        child: _image == null
                            ? _tempImage
                            : Container(
                                child: Image.file(File(_image!.path),
                                    fit: BoxFit.cover),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10))),
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
                            // Add your editing logic here
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
                  SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        prefixIcon: Icon(
                          Icons.local_dining,
                          color: primeryColor,
                        ),
                        prefixText: "Recipe Name    ",
                        prefixStyle: TextStyle(
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
                  SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        prefixIcon: Icon(
                          Icons.person,
                          color: primeryColor,
                        ),
                        prefixText: "Serves    ",
                        prefixStyle: TextStyle(
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
                  SizedBox(height: 20),
                  TextField(
                    textAlign: TextAlign.end,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20),
                        prefixIcon: Icon(
                          Icons.access_time,
                          color: primeryColor,
                        ),
                        prefixText: "Cooking Time    ",
                        prefixStyle: TextStyle(
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
                  SizedBox(height: 20),
                  Text("Ingredients",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Container(
                    height: 250,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: _controllers.length,
                            itemBuilder: (context, index) {
                              if (index.isOdd) {
                                return SizedBox(height: 8);
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
                                              BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
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
                                    icon: Icon(Icons.remove_circle),
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
                  SizedBox(height: 20),
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
                              child: Center(child: Text('Save My Recipe')),
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
